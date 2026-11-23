import 'package:get/get.dart';
import 'package:vlts_swc/features/splash/viewModels/splash_view_model.dart';
import 'package:vlts_swc/features/splash/views/splash_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/login/views/login_view.dart';
import '../../features/overview/view/overview_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashViewModel>(
              () => SplashViewModel(),
        );
      }),
    ),
    GetPage(
      name: Routes.overview,
      page: () => const OverviewScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
