import 'package:either_dart/either.dart';
import '../../../../core/errors/failure.dart';
import '../models/ulb_model.dart';

/// Repository contract for Home screen and ULB progress data.
abstract class HomeRepository {
  Future<Either<Failure, UlbModel>> getUlbWiseProgressList({
    required Map<String, dynamic> requestBody,
  });
}
