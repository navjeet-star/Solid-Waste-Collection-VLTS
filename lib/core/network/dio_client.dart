import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_endpoints.dart';

/// Production-ready Dio HTTP Client factory and manager.
/// Centralizes configuration of timeouts, headers, PrettyDioLogger, and SSL certificate handling.
class DioClient {
  DioClient._();

  static Dio? _instance;

  /// Returns a shared singleton [Dio] instance.
  static Dio get instance {
    _instance ??= createDio();
    return _instance!;
  }

  /// Creates and configures a new [Dio] instance with interceptors and SSL handling.
  static Dio createDio({String? baseUrl}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiEndpoints.authApiBase,
        connectTimeout: ApiEndpoints.connectTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        sendTimeout: ApiEndpoints.sendTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // 1. SSL Certificate Bypass for Dev/Staging (.gov.in intermediate CA validation)
    if (!kReleaseMode) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    // 2. Production-Grade PrettyDioLogger
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
}

