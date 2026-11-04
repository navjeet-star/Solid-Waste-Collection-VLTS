import 'package:get/get.dart';
import '../../features/home/home_screen.dart';
import '../../features/login/bindings/login_binding.dart';
import '../../features/login/views/login_view.dart';
import '../../features/overview/view/overview_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.overview;

  static final routes = [
    GetPage(
      name: Routes.overview,
      page: () => const OverviewScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
    ),
  ];
}
