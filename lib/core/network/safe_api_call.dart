import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:retrofit/retrofit.dart';

import '../errors/exceptions.dart';
import '../errors/failure.dart';
import 'error_handler.dart';

/// Centralized execution wrapper for all API network calls.
/// Automatically handles:
/// - HTTP Status Codes (200-299 success, 4xx/5xx failures)
/// - DioError (timeouts, no connection, response errors, cancellations)
/// - Domain Exceptions ([ServerException], [NetworkException], [AuthException])
/// - Unhandled Exceptions
///
/// Returns [Right(data)] on success or [Left(Failure)] on any error,
/// eliminating duplicate try-catch blocks and error checks across all repositories.
Future<Either<Failure, T>> safeApiCall<T>(
  Future<dynamic> Function() apiCall,
) async {
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

