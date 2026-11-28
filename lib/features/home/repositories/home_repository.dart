import 'package:either_dart/either.dart';
import 'package:vlts_swc/core/network/base_api_response.dart';
import 'package:vlts_swc/models/AttendanceStatusList.dart';
import 'package:vlts_swc/models/ulb_model.dart';
import '../../../../core/errors/failure.dart';

/// Repository contract for Home screen and ULB progress data.
abstract class HomeRepository {
  Future<Either<Failure, UlbModel>> getUlbWiseProgressList({
    required Map<String, dynamic> requestBody,
  });

  Future<Either<Failure, ApiResponse<List<AttendanceStatusList>>>>
      getAttendanceStatus({
    required Map<String, dynamic> requestBody,
  });
}
