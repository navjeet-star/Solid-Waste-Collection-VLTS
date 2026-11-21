import 'package:either_dart/either.dart';
import '../../../../core/errors/failure.dart';
import '../models/LoginModel.dart';

/// Repository contract for authentication in MVVM architecture.
abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login({
    required String loginId,
    required String password,
    required String? salt,
  });
}



