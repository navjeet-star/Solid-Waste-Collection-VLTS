import 'package:either_dart/either.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/LoginModel.dart';
import 'login_repository.dart';

/// Concrete implementation of [LoginRepository].
/// Executes authentication API calls directly via [ApiClient].
class LoginRepositoryImpl implements LoginRepository {
  final ApiClient apiClient;

  LoginRepositoryImpl({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient.instance;

  @override
  Future<Either<Failure, LoginModel>> login({
    required String loginId,
    required String password,
    required String? salt,
  }) {
    return apiClient.post<LoginModel>(
      ApiEndpoints.departmentUserAuth,
      data: {
        "LoginID": loginId,
        "Password": password,
        "Salt": salt,
      },
      fromJson: (json) => LoginModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
