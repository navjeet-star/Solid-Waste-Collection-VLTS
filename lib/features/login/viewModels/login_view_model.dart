import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' as SharedPreferences;
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/aes_encypt.dart';
import 'package:vlts_swc/core/base/base_view_model.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/features/login/models/ProfileDetail.dart';
import 'package:vlts_swc/features/login/repositories/LoginRepositoryImpl.dart';
import '../models/LoginModel.dart';
import '../repositories/login_repository.dart';

/// MVVM ViewModel for the Login screen.
/// Extends [BaseViewModel] for centralized loading and error states.
class LoginViewModel extends BaseViewModel {
  final LoginRepository repository;

  LoginViewModel({LoginRepository? repository})
      : repository = repository ??
            (Get.isRegistered<LoginRepository>()
                ? Get.find<LoginRepository>()
                : LoginRepositoryImpl());

  final emailController = TextEditingController(text: 'super-admin');
  final passwordController = TextEditingController(text: 'Nic@2025');
  final formKey = GlobalKey<FormState>();

  // Reactive UI States
  final RxBool isPasswordHidden = true.obs;
  final RxBool rememberMe = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleRememberMe([bool? value]) {
    rememberMe.value = value ?? !rememberMe.value;
  }

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      setLoading();

      final encryptionHelper = AESENCRYPTION();
      final salt = encryptionHelper.getSalt(5);

      // Encrypt LoginID
      final userName = encryptionHelper.aesEncryption(
        plainText: emailController.text.trim(),
      );

      // Hash password + salt, then encrypt
      final hashedPassword = encryptionHelper.getSha256(
        passwordController.text + salt,
      );
      final password = encryptionHelper.aesEncryption(
        plainText: hashedPassword,
      );
      final encryptedSalt = encryptionHelper.aesEncryption(plainText: salt);

      // Centralized API call via repository:
      // - Pre-flight internet check, BaseApiResponse status check, and user-facing error toasts
      //   are all handled centrally by safeApiCall.
      final result = await repository.login(
        loginId: userName,
        password: password,
        salt: encryptedSalt,
      );

      result.fold(
        (failure) {
          setError(failure.message);
        },
        (userData) async {
          setSuccess();
          // 1. Save data in SharedPreferences & Secure Storage
          await SharedPrefsService.saveLoginResponse(userData);
          final savedResponse = await SharedPrefsService.getLoginResponse();
          debugPrint('INFO: Login Response: ${savedResponse?.toJson()}');
          Get.offAllNamed(Routes.home);
        },
      );
    } catch (e) {
      setError(e.toString());
    } finally {
      if (isLoading.value && !isError && !isSuccess) {
        resetState();
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

/// Backwards compatibility alias for LoginController
typedef LoginController = LoginViewModel;
