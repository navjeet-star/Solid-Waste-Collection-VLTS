import 'dart:io';
import 'package:dio/dio.dart';
import '../errors/exceptions.dart';

/// Centralized API and Network Error Handler.
/// Translates Dio exceptions, HTTP response codes, and network failures
/// into clean, domain-ready [ServerException] instances.

class ApiErrorHandler {
  ApiErrorHandler._();

  /// Translates a [DioError] into a domain-level [ServerException].
  static ServerException handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return ServerException(
          message: 'Connection timed out. Please check your internet connection.',
          statusCode: 408,
        );

      case DioErrorType.sendTimeout:
        return ServerException(
          message: 'Request timed out while sending data to server.',
          statusCode: 408,
        );

      case DioErrorType.receiveTimeout:
        return ServerException(
          message: 'Server took too long to respond. Please try again later.',
          statusCode: 504,
        );

      case DioErrorType.response:
        return _handleHttpResponse(error.response);

      case DioErrorType.cancel:
        return ServerException(
          message: 'Request was cancelled.',
          statusCode: 499,
        );

      case DioErrorType.other:
        if (error.error is SocketException) {
          return ServerException(
            message: 'No internet connection. Please verify your network.',
            statusCode: 503,
          );
        }
        return ServerException(
          message: error.message ?? 'An unexpected network error occurred.',
          statusCode: 500,
        );
    }
  }

  /// Extracts readable error messages from HTTP error responses.
  static ServerException _handleHttpResponse(Response? response) {
    final statusCode = response?.statusCode ?? 500;
    String errorMessage = _extractErrorMessage(response?.data);

    if (errorMessage.isEmpty) {
      switch (statusCode) {
        case 400:
          errorMessage = 'Bad request. Please verify the request parameters.';
          break;
        case 401:
          errorMessage = 'Unauthorized. Please check your credentials.';
          break;
        case 403:
          errorMessage = 'Access denied. You do not have permission.';
          break;
        case 404:
          errorMessage = 'Requested resource not found on server.';
          break;
        case 408:
          errorMessage = 'Request timeout.';
          break;
        case 422:
          errorMessage = 'Validation error. Please check your inputs.';
          break;
        case 500:
          errorMessage = 'Internal server error. Please try again later.';
          break;
        case 502:
          errorMessage = 'Bad gateway. The server is temporarily unavailable.';
          break;
        case 503:
          errorMessage = 'Service unavailable. Server is under maintenance.';
          break;
        case 504:
          errorMessage = 'Gateway timeout. Server response delayed.';
          break;
        default:
          errorMessage = response?.statusMessage ?? 'Server error occurred ($statusCode)';
      }
    }

    return ServerException(
      message: errorMessage,
      statusCode: statusCode,
    );
  }

  /// Parses error message from multiple backend formats:
  /// e.g. `{ "Message": "..." }`, `{ "message": "..." }`, `{ "error": "..." }`, or raw String.
  static String _extractErrorMessage(dynamic data) {
    if (data == null) return '';

    if (data is String) return data.trim();

    if (data is Map<String, dynamic>) {
      if (data.containsKey('Message') && data['Message'] != null) {
        return data['Message'].toString();
      }
      if (data.containsKey('message') && data['message'] != null) {
        return data['message'].toString();
      }
      if (data.containsKey('error') && data['error'] != null) {
        return data['error'].toString();
      }
      if (data.containsKey('error_description') && data['error_description'] != null) {
        return data['error_description'].toString();
      }
      if (data.containsKey('title') && data['title'] != null) {
        return data['title'].toString();
      }
    }

    return '';
  }
}

