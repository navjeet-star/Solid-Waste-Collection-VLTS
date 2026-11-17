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
          message: error.message.isNotEmpty
              ? error.message
              : 'An unexpected network error occurred.',
          statusCode: 500,
        );
    }
  }

  /// Extracts readable error messages from HTTP error responses.
  static ServerException _handleHttpResponse(Response? response) {
    final statusCode = response?.statusCode ?? 500;
    String errorMessage = _extractErrorMessage(response?.data);

    if (errorMessage.isEmpty) {
      errorMessage = getHttpErrorMessage(statusCode, response?.statusMessage);
    }

    return ServerException(
      message: errorMessage,
      statusCode: statusCode,
    );
  }

  /// Returns user-friendly messages for standard HTTP error codes.
  static String getHttpErrorMessage(int statusCode, [String? defaultMsg]) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please verify the request parameters.';
      case 401:
        return 'Unauthorized. Please check your credentials or log in again.';
      case 403:
        return 'Access denied. You do not have permission.';
      case 404:
        return 'Requested resource not found on server.';
      case 408:
        return 'Request timeout. Please check your network connection.';
      case 409:
        return 'Conflict. The resource already exists or conflict occurred.';
      case 422:
        return 'Validation error. Please check your inputs.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad gateway. The server is temporarily unavailable.';
      case 503:
        return 'Service unavailable. Server is under maintenance.';
      case 504:
        return 'Gateway timeout. Server response delayed.';
      default:
        return defaultMsg ?? 'Server error occurred ($statusCode)';
    }
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

