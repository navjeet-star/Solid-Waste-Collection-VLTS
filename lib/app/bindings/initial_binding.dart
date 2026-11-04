import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_service.dart';
import '../../core/network/dio_client.dart';

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
  }
}
