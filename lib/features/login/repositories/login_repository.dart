import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../models/requestParams/auth_params.dart';
import '../models/login_model.dart';

/// Repository contract for authentication in MVVM architecture.
abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login({
    required String loginId,
    required String password,
    required String? salt,
  });
}

/// Concrete implementation of [LoginRepository].
/// Coordinates network calls via [ApiService] and translates exceptions into domain [Failure]s.
class LoginRepositoryImpl implements LoginRepository {
  final ApiService apiService;

  LoginRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, LoginModel>> login({
    required String loginId,
    required String password,
    required String? salt,
  }) async {
    try {
      final authParams = AuthParams(
        loginID: loginId,
        password: password,
        salt: salt,
      );

      final httpResponse = await apiService.isAppActive(authParams);

      if (httpResponse.response.statusCode != null &&
          httpResponse.response.statusCode! >= 200 &&
          httpResponse.response.statusCode! < 300) {
        return Right(httpResponse.data);
      } else {
        return Left(
          ServerFailure(
            message: httpResponse.response.statusMessage ?? 'Server error',
            statusCode: httpResponse.response.statusCode,
          ),
        );
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
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

