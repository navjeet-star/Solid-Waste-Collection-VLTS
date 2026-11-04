import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/dio_client.dart';
import '../repositories/login_repository.dart';
import '../viewModels/login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Core Network dependencies fallback if not registered by InitialBinding
    if (!Get.isRegistered<Dio>()) {
      Get.lazyPut<Dio>(() => DioClient.createDio());
    }

    if (!Get.isRegistered<ApiService>()) {
      Get.lazyPut<ApiService>(
        () => ApiService(
          dio: Get.find<Dio>(),
          baseUrl: ApiEndpoints.authApiBase,
        ),
      );
    }

    // Repository
    Get.lazyPut<LoginRepository>(
      () => LoginRepositoryImpl(apiService: Get.find<ApiService>()),
    );

    // ViewModel
    Get.lazyPut<LoginViewModel>(
      () => LoginViewModel(repository: Get.find<LoginRepository>()),
    );
  }
}

