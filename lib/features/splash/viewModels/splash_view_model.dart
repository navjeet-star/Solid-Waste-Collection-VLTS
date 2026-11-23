
import 'package:get/get.dart';

import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';

class SplashViewModel extends GetxController {

  /// Determines the next screen and navigates accordingly.
  Future<void> navigateToNextRoute() async {
    try {
      // Initialize SharedPreferences.
      await SharedPrefsService.init();

      String destination;

      // First-time user.
      if (SharedPrefsService.isFirstLaunch) {
        destination = Routes.overview;
      }

      // Existing logged-in user.
      else if (SharedPrefsService.isLoggedIn) {
        final loginResponse =
        await SharedPrefsService.getLoginResponse();

        final accessToken =
        await SharedPrefsService.getAccessToken();

        if (loginResponse != null &&
            accessToken != null &&
            accessToken.isNotEmpty) {
          destination = Routes.home;
        } else {
          destination = Routes.login;
        }
      }

      // User is not logged in.
      else {
        destination = Routes.login;
      }

      // Navigate only if ViewModel is still active.
      if (!isClosed) {
        Get.offAllNamed(destination);
      }
    } catch (e) {
      // Fallback to Login if initialization fails.
      if (!isClosed) {
        Get.offAllNamed(Routes.login);
      }
    }
  }
}
