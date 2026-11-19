import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/aes_encypt.dart';
import 'package:vlts_swc/core/base/base_view_model.dart';
import 'package:vlts_swc/core/services/shared_prefs_service.dart';
import 'package:vlts_swc/features/login/repositories/LoginRepositoryImpl.dart';
import '../models/login_model.dart';
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
  final Rxn<LoginModel> user = Rxn<LoginModel>();

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
          user.value = userData;

          // Save login response & profile in SharedPreferences
          await SharedPrefsService.instance.saveLoginResponse(userData);
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
