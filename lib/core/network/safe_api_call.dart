import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:retrofit/retrofit.dart';

import '../../common_utils/common_functions.dart';
import '../errors/exceptions.dart';
import '../errors/failure.dart';
import 'error_handler.dart';
import 'network_info.dart';

/// Centralized execution wrapper for all API network calls.
/// Automatically handles:
/// - Pre-flight internet connectivity checks (shows toast and aborts if offline)
/// - HTTP Status Codes (200-299 success, 4xx/5xx failures)
/// - DioError (timeouts, no connection, response errors, cancellations)
/// - Domain Exceptions ([ServerException], [NetworkException], [AuthException])
/// - Unhandled Exceptions
///
/// Returns [Right(data)] on success or [Left(Failure)] on any error,
/// eliminating duplicate try-catch blocks and error checks across all repositories.
Future<Either<Failure, T>> safeApiCall<T>(
  Future<dynamic> Function() apiCall, {
  bool checkInternet = true,
  bool showOfflineToast = true,
}) async {
  if (checkInternet) {
    final isConnected = await NetworkInfo.isConnected();
    if (!isConnected) {
      const offlineMsg = "No internet connection. Please check your network.";
      if (showOfflineToast) {
        CommonFunctions.showToast(offlineMsg);
      }
      return Left(
        NetworkFailure(message: offlineMsg),
      );
    }
  }

  try {
    final result = await apiCall();

    if (result is HttpResponse) {
      final statusCode = result.response.statusCode ?? 200;
      if (statusCode >= 200 && statusCode < 300) {
        return Right(result.data as T);
      } else {
        final errorMsg = ApiErrorHandler.getHttpErrorMessage(
          statusCode,
          result.response.statusMessage,
        );
        return Left(
          ServerFailure(
            message: errorMsg,
            statusCode: statusCode,
          ),
        );
      }
    } else if (result is T) {
      return Right(result);
    } else {
      return Right(result as T);
    }
  } on DioError catch (e) {
    final exception = ApiErrorHandler.handleDioError(e);
    return Left(
      ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      ),
    );
  } on ServerException catch (e) {
    return Left(
      ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ),
    );
  } on NetworkException catch (e) {
    return Left(
      NetworkFailure(
        message: e.message,
      ),
    );
  } on AuthException catch (e) {
    return Left(
      AuthFailure(
        message: e.message,
      ),
    );
  } catch (e) {
    return Left(
      ServerFailure(
        message: e.toString(),
      ),
    );
  }
}

