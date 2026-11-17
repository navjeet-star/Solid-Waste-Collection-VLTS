import 'package:either_dart/either.dart';
import 'package:vlts_swc/features/login/repositories/login_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/safe_api_call.dart';
import '../models/login_model.dart';

/// Concrete implementation of [LoginRepository].
/// Coordinates network calls via [ApiService] with centralized error handling.
class LoginRepositoryImpl implements LoginRepository {
  final ApiService apiService;

  LoginRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, LoginModel>> login({
    required String loginId,
    required String password,
    required String? salt,
  }) {
    return safeApiCall(
      () => apiService.isAppActive({
        "LoginID": loginId,
        "Password": password,
        "Salt": salt,
      }),
    );
  }
}
