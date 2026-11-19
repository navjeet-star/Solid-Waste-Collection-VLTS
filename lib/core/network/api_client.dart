import 'dart:async';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../common_utils/common_functions.dart';
import '../aes_encypt.dart';
import '../errors/failure.dart';
import '../services/shared_prefs_service.dart';
import 'api_endpoints.dart';
import 'base_api_response.dart';
import 'error_handler.dart';
import 'network_info.dart';

/// Centralized, production-ready HTTP Client and Network Engine for Flutter MVVM.
///
/// Handles:
/// - Pre-flight internet connectivity checks with user toasts.
/// - Centralized Bearer token injection from [SharedPrefsService].
/// - Multi-base URL support (AuthApi, OfficeApi, MasterApi).
/// - Standardized [BaseApiResponse] validation (Code "S" vs "F").
/// - Automatic silent token regeneration & request retry on token expiration.
/// - Error translation returning [Either<Failure, T>].
class ApiClient {
  ApiClient._() {
    _dio = _createDio();
  }

  static ApiClient? _instance;
  static ApiClient get instance => _instance ??= ApiClient._();

  late final Dio _dio;
  Dio get dio => _dio;

  Completer<bool>? _refreshCompleter;

  // =============================================================
  // Dio Initialization
  // =============================================================

  Dio _createRawDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: ApiEndpoints.connectTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        sendTimeout: ApiEndpoints.sendTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (!kReleaseMode) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) =>
              client..badCertificateCallback = (cert, host, port) => true;
    }

    return dio;
  }

  Dio _createDio() {
    final dio = _createRawDio();

    // 1. Authorization Bearer Token Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SharedPrefsService.instance.accessTokenSync;
          if (token != null &&
              token.isNotEmpty &&
              !options.headers.containsKey('Authorization')) {
            options.headers['Authorization'] =
                token.startsWith('Bearer') ? token : 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          if (error.response?.statusCode == 401) {
            Log.w("ApiClient", "401 Unauthorized: ${error.requestOptions.path}");
          }
          return handler.next(error);
        },
      ),
    );

    // 2. Pretty Logger Interceptor
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    return dio;
  }

  // =============================================================
  // Core Request Engine with Auto Token Renewal & Retry
  // =============================================================

  Future<Either<Failure, T>> _request<T>({
    required String method,
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic json) fromJson,
    bool checkInternet = true,
    bool showErrorToast = true,
    bool isRetry = false,
  }) async {
    // 1. Pre-flight Internet Connectivity Check
    if (checkInternet && !await NetworkInfo.isConnected()) {
      const offlineMsg = "No internet connection. Please check your network.";
      if (showErrorToast) CommonFunctions.showToast(offlineMsg);
      return Left(const NetworkFailure(message: offlineMsg));
    }

    // 2. Execute HTTP Request
    try {
      final response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(method: method),
      );

      final responseData = response.data;
      if (responseData == null) {
        return Left(const ServerFailure(message: "Empty response from server."));
      }

      final model = fromJson(responseData);

      // 3. Centralized BaseApiResponse status validation (Code == "S" vs "F")
      if (model is BaseApiResponse && !model.isSuccess) {
        final errorMsg =
            (model.message != null && model.message!.trim().isNotEmpty)
                ? model.message!
                : "Request failed. Please try again.";

        // Handle token expiration in 200 OK response with Code "F"
        if (!isRetry &&
            _isTokenExpired(message: errorMsg, responseData: responseData)) {
          return await _handleTokenExpiredAndRetry<T>(
            method: method,
            url: url,
            data: data,
            queryParameters: queryParameters,
            options: options,
            fromJson: fromJson,
            showErrorToast: showErrorToast,
          );
        }

        if (showErrorToast) CommonFunctions.showToast(errorMsg);
        return Left(ServerFailure(message: errorMsg));
      }

      return Right(model);
    } on DioError catch (e) {
      // Handle token expiration in HTTP 401 or DioError response
      if (!isRetry &&
          _isTokenExpired(
            statusCode: e.response?.statusCode,
            message: e.message,
            responseData: e.response?.data,
          )) {
        return await _handleTokenExpiredAndRetry<T>(
          method: method,
          url: url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          fromJson: fromJson,
          showErrorToast: showErrorToast,
        );
      }

      final exception = ApiErrorHandler.handleDioError(e);
      if (showErrorToast) CommonFunctions.showToast(exception.message);
      return Left(
        ServerFailure(
          message: exception.message,
          statusCode: exception.statusCode,
        ),
      );
    } catch (e) {
      final message = e.toString();
      if (showErrorToast) CommonFunctions.showToast(message);
      return Left(ServerFailure(message: message));
    }
  }

  // =============================================================
  // Token Expiration Detection, Regeneration & Retry
  // =============================================================

  bool _isTokenExpired({
    int? statusCode,
    String? message,
    dynamic responseData,
  }) {
    if (statusCode == 401) return true;
    final serverMsg = responseData is Map
        ? (responseData['Message'] ?? responseData['message'])?.toString()
        : null;
    final combined = '${message ?? ''} ${serverMsg ?? ''}'.toLowerCase();
    return combined.contains('access token has been expired') ||
        combined.contains('token has been expired') ||
        combined.contains('access token expired') ||
        combined.contains('token expired') ||
        combined.contains('token has expired');
  }

  Future<Either<Failure, T>> _handleTokenExpiredAndRetry<T>({
    required String method,
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic json) fromJson,
    required bool showErrorToast,
  }) async {
    Log.w("ApiClient", "Token expired. Regenerating access token...");
    final refreshed = await _regenerateAccessToken();

    if (!refreshed) {
      await _handleSessionExpired();
      return Left(
          const ServerFailure(message: "Session expired. Please log in again."));
    }

    final headers = Map<String, dynamic>.from(options?.headers ?? {});
    final newToken = SharedPrefsService.instance.accessTokenSync;
    if (newToken != null && newToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $newToken';
    }

    return await _request<T>(
      method: method,
      url: url,
      data: data,
      queryParameters: queryParameters,
      options: (options ?? Options()).copyWith(headers: headers),
      fromJson: fromJson,
      checkInternet: false,
      showErrorToast: showErrorToast,
      isRetry: true,
    );
  }

  Future<bool> _regenerateAccessToken() async {
    if (_refreshCompleter != null) return _refreshCompleter!.future;

    final completer = Completer<bool>();
    _refreshCompleter = completer;

    try {
      final prefs = SharedPrefsService.instance;
      final loginId = prefs.loginIdSync??'';
      final refreshToken = prefs.refreshTokenSync ?? '';

      if (loginId.isEmpty || refreshToken.isEmpty) {
        Log.e("ApiClient", "Cannot refresh token: loginId or refreshToken is missing.");
        completer.complete(false);
        return false;
      }

      final aes = AESENCRYPTION();
      final payload = {
        "LoginID": aes.aesEncryption(plainText: loginId),
        "RefreshToken": aes.aesEncryption(plainText: refreshToken),
      };

      Log.d("ApiClient", "Calling RegenerateAccessTokenDepartmentUser for $loginId...");
      final client = _createRawDio();
      final response = await client.post(
        ApiEndpoints.regenerateAccessTokenDepartmentUser,
        data: payload,
      );

      final resData = response.data;
      final code =
          resData is Map ? (resData['Code'] ?? resData['code'])?.toString() : null;

      if (code == 'S' && resData is Map<String, dynamic>) {
        final tokens =
            resData['Tokens'] is Map ? resData['Tokens'] as Map : resData;
        final newAccess =
            (tokens['AccessToken'] ?? tokens['accessToken'])?.toString();
        final newRefresh =
            (tokens['RefreshToken'] ?? tokens['refreshToken'])?.toString();

        if (newAccess != null && newAccess.isNotEmpty) {
          await prefs.updateTokens(
            accessToken: newAccess,
            refreshToken: newRefresh,
          );
          Log.i("ApiClient", "Access token successfully refreshed.");
          completer.complete(true);
          return true;
        }
      }

      Log.e("ApiClient", "Failed to refresh token: ${resData?['Message']}");
      completer.complete(false);
      return false;
    } catch (e) {
      Log.e("ApiClient", "Error during token refresh: $e");
      if (!completer.isCompleted) completer.complete(false);
      return false;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> _handleSessionExpired() async {
    Log.e("ApiClient", "Session completely expired. Redirecting to Login...");
    CommonFunctions.showToast("Your session has expired. Please log in again.");
    await SharedPrefsService.instance.logout();
  }

  // =============================================================
  // Public HTTP API Methods
  // =============================================================

  /// Centralized POST method
  Future<Either<Failure, T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic json) fromJson,
    bool checkInternet = true,
    bool showErrorToast = true,
  }) {
    return _request<T>(
      method: 'POST',
      url: url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      fromJson: fromJson,
      checkInternet: checkInternet,
      showErrorToast: showErrorToast,
    );
  }

  /// Centralized GET method
  Future<Either<Failure, T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic json) fromJson,
    bool checkInternet = true,
    bool showErrorToast = true,
  }) {
    return _request<T>(
      method: 'GET',
      url: url,
      queryParameters: queryParameters,
      options: options,
      fromJson: fromJson,
      checkInternet: checkInternet,
      showErrorToast: showErrorToast,
    );
  }
}
