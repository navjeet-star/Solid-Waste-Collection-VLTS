import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/features/login/repositories/LoginRepositoryImpl.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_service.dart';
import '../../core/network/dio_client.dart';
import '../../features/login/repositories/login_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {

    // Global Dio instance
    Get.lazyPut<Dio>(() => DioClient.createDio(), fenix: true);

    // Global ApiService instance
    Get.lazyPut<ApiService>(
      () => ApiService(
        dio: Get.find<Dio>(),
        baseUrl: ApiEndpoints.authApiBase,
      ),
      fenix: true,
    );

    // Global LoginRepository instance
    Get.lazyPut<LoginRepository>(
      () => LoginRepositoryImpl(apiService: Get.find<ApiService>()),
      fenix: true,
    );
  }
}
