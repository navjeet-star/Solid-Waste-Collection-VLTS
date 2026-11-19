import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../common_utils/common_functions.dart';
import '../errors/failure.dart';
import '../services/shared_prefs_service.dart';
import 'api_endpoints.dart';
import 'base_api_response.dart';
import 'error_handler.dart';
import 'network_info.dart';

/// Centralized, production-ready HTTP Client and Network Engine for Flutter MVVM.
///
/// Features:
/// 1. Direct API execution without code generators (Retrofit) or intermediate wrappers.
/// 2. Automatic pre-flight internet connectivity checks (aborts and toasts if offline).
/// 3. Centralized Authorization Bearer token injection from [SharedPrefsService].
/// 4. Common [BaseApiResponse.isSuccess] checking (Code == "S" vs "F") with auto-toasts.
/// 5. Standardized error translation via [ApiErrorHandler] returning [Either<Failure, T>].
/// 6. Multi-base URL support (AuthApi, OfficeApi, MasterApi, etc.) in a single Dio instance.
class ApiClient {
  ApiClient._() {
    _dio = _createDio();
  }

  static ApiClient? _instance;
  static ApiClient get instance => _instance ??= ApiClient._();

  late final Dio _dio;
  Dio get dio => _dio;

  Dio _createDio() {
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

    // Development-only SSL bypass for local HTTPS development
    if (!kReleaseMode) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    // 1. Centralized Authorization Token Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SharedPrefsService.instance.accessTokenSync;
          if (token != null &&
              token.isNotEmpty &&
              !options.headers.containsKey('Authorization')) {
            if (token.startsWith('Bearer ') || token.startsWith('Bearer')) {
              options.headers['Authorization'] = token;
            } else {
              options.headers['Authorization'] = 'Bearer $token';
            }
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

    // 2. Logging Interceptor
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

  /// Centralized POST method
  Future<Either<Failure, T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic json) fromJson,
    bool checkInternet = true,
    bool showErrorToast = true,
  }) async {
    // 1. Pre-flight Internet Connectivity Check
    if (checkInternet) {
      final isOnline = await NetworkInfo.isConnected();
      if (!isOnline) {
        const offlineMsg = "No internet connection. Please check your network.";
        if (showErrorToast) {
          CommonFunctions.showToast(offlineMsg);
        }
        return Left(const NetworkFailure(message: offlineMsg));
      }
    }

    // 2. Execute HTTP POST
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      final responseData = response.data;
      if (responseData == null) {
        return Left(const ServerFailure(message: "Empty response from server."));
      }

      final model = fromJson(responseData);

      // 3. Centralized BaseApiResponse status validation (Code == "S" vs "F")
      if (model is BaseApiResponse && !model.isSuccess) {
        final errorMsg = (model.message != null && model.message!.trim().isNotEmpty)
            ? model.message!
            : "Request failed. Please try again.";
        if (showErrorToast) {
          CommonFunctions.showToast(errorMsg);
        }
        return Left(ServerFailure(message: errorMsg));
      }

      return Right(model);
    } on DioError catch (e) {
      final exception = ApiErrorHandler.handleDioError(e);
      if (showErrorToast) {
        CommonFunctions.showToast(exception.message);
      }
      return Left(
        ServerFailure(
          message: exception.message,
          statusCode: exception.statusCode,
        ),
      );
    } catch (e) {
      final message = e.toString();
      if (showErrorToast) {
        CommonFunctions.showToast(message);
      }
      return Left(ServerFailure(message: message));
    }
  }

  /// Centralized GET method
  Future<Either<Failure, T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic json) fromJson,
    bool checkInternet = true,
    bool showErrorToast = true,
  }) async {
    // 1. Pre-flight Internet Connectivity Check
    if (checkInternet) {
      final isOnline = await NetworkInfo.isConnected();
      if (!isOnline) {
        const offlineMsg = "No internet connection. Please check your network.";
        if (showErrorToast) {
          CommonFunctions.showToast(offlineMsg);
        }
        return Left(const NetworkFailure(message: offlineMsg));
      }
    }

    // 2. Execute HTTP GET
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );

      final responseData = response.data;
      if (responseData == null) {
        return Left(const ServerFailure(message: "Empty response from server."));
      }

      final model = fromJson(responseData);

      // 3. Centralized BaseApiResponse status validation
      if (model is BaseApiResponse && !model.isSuccess) {
        final errorMsg = (model.message != null && model.message!.trim().isNotEmpty)
            ? model.message!
            : "Request failed. Please try again.";
        if (showErrorToast) {
          CommonFunctions.showToast(errorMsg);
        }
        return Left(ServerFailure(message: errorMsg));
      }

      return Right(model);
    } on DioError catch (e) {
      final exception = ApiErrorHandler.handleDioError(e);
      if (showErrorToast) {
        CommonFunctions.showToast(exception.message);
      }
      return Left(
        ServerFailure(
          message: exception.message,
          statusCode: exception.statusCode,
        ),
      );
    } catch (e) {
      final message = e.toString();
      if (showErrorToast) {
        CommonFunctions.showToast(message);
      }
      return Left(ServerFailure(message: message));
    }
  }
}
