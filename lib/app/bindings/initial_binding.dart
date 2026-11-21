import 'package:get/get.dart';
import 'package:vlts_swc/core/network/api_client.dart';
import 'package:vlts_swc/features/home/repositories/HomeRepositoryImpl.dart';
import 'package:vlts_swc/features/home/repositories/home_repository.dart';
import 'package:vlts_swc/features/login/repositories/LoginRepositoryImpl.dart';
import 'package:vlts_swc/features/login/repositories/login_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {

    // Global ApiClient instance
    Get.lazyPut<ApiClient>(() => ApiClient.instance, fenix: true);

    // Global LoginRepository instance
    Get.lazyPut<LoginRepository>(
      () => LoginRepositoryImpl(apiClient: Get.find<ApiClient>()),
      fenix: true,
    );

    // Global HomeRepository instance
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(apiClient: Get.find<ApiClient>()),
      fenix: true,
    );
  }
}
