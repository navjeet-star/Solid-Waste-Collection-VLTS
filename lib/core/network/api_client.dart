
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../common_utils/common_functions.dart';
import '../errors/failure.dart';
import '../storage/shared_prefs_service.dart';
import 'api_endpoints.dart';
import 'base_api_response.dart';
import 'error_handler.dart';
import 'network_info.dart';

class ApiClient {
  ApiClient._() {
    _dio = _createDio();
  }

  static ApiClient? _instance;

  static ApiClient get instance =>
      _instance ??= ApiClient._();

  late final Dio _dio;

  Dio get dio => _dio;

  // ==========================================
  // DIO INITIALIZATION
  // ==========================================

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

    // Allow self-signed certificates in debug only.
    if (!kReleaseMode) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.badCertificateCallback =
            (cert, host, port) => true;
        return client;
      };
    }

    // ==========================================
    // AUTHORIZATION INTERCEPTOR
    // ==========================================

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token =
            await SharedPrefsService.getAccessToken();

            if (token != null && token.isNotEmpty && !options.headers.containsKey('Authorization')) {
              options.headers['Authorization'] = 'Bearer $token';
            }

            handler.next(options);
          } catch (e) {
            handler.reject(
              DioError (
                requestOptions: options,
                error: e,
              ),
            );
          }
        },
      ),
    );

    // ==========================================
    // API LOGGER
    // ==========================================

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    return dio;
  }

  // ==========================================
  // CORE REQUEST METHOD
  // ==========================================

  Future<Either<Failure, T>> _request<T>({
    required String method,
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic json) fromJson,
    bool checkInternet = true,
    bool showErrorToast = true,
  }) async {
    // Check internet connection
    if (checkInternet &&
        !await NetworkInfo.isConnected()) {
      const message =
          'No internet connection. Please check your network.';

      if (showErrorToast) {
        CommonFunctions.showToast(message);
      }

      return Left(
        const NetworkFailure(message: message),
      );
    }

    try {
      final response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          method: method,
        ),
      );

      if (response.data == null) {
        return Left(
          const ServerFailure(
            message: 'Empty response from server.',
          ),
        );
      }

      final model = fromJson(response.data);

      // Validate API response
      if (model is BaseApiResponse && !model.isSuccess) {
        final message =
        (model.message != null &&
            model.message!.trim().isNotEmpty)
            ? model.message!
            : 'Request failed. Please try again.';

        if (showErrorToast) {
          CommonFunctions.showToast(message);
        }

        return Left(
          ServerFailure(message: message),
        );
      }

      return Right(model);
    } on DioError  catch (e) {
      final exception =
      ApiErrorHandler.handleDioError(e);

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

      return Left(
        ServerFailure(message: message),
      );
    }
  }

  // ==========================================
  // POST REQUEST
  // ==========================================

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

  // ==========================================
  // GET REQUEST
  // ==========================================

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
