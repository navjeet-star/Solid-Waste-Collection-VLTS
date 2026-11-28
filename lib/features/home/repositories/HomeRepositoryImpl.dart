import 'package:either_dart/either.dart';
import 'package:vlts_swc/core/network/base_api_response.dart';
import 'package:vlts_swc/models/AttendanceStatusList.dart';
import 'package:vlts_swc/models/ulb_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import 'home_repository.dart';

/// Concrete implementation of [HomeRepository].
/// Executes ULB progress API requests directly via [ApiClient].
class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;

  HomeRepositoryImpl({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient.instance;

  @override
  Future<Either<Failure, UlbModel>> getUlbWiseProgressList({
    required Map<String, dynamic> requestBody,
  }) {
    return apiClient.post<UlbModel>(
      ApiEndpoints.uLBWiseProgressList,
      data: requestBody,
      fromJson: (json) => UlbModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, ApiResponse<List<AttendanceStatusList>>>>
      getAttendanceStatus({
    required Map<String, dynamic> requestBody,
  }) {
    return apiClient.post<ApiResponse<List<AttendanceStatusList>>>(
      ApiEndpoints.getAttendanceStatus,
      data: requestBody,
      fromJson: (json) => ApiResponse.fromJson(
        json as Map<String, dynamic>,
        (data) => (data is List)
            ? data.map((e) => AttendanceStatusList.fromJson(e)).toList()
            : <AttendanceStatusList>[],
        dataKey: 'AttendanceStatusList',
      ),
    );
  }
}
