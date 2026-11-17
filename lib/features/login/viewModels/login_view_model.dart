import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/features/login/repositories/LoginRepositoryImpl.dart';

import '../../../../app/routes/app_pages.dart';
import '../../../../common_utils/common_functions.dart';
import '../../../../core/aes_encypt.dart';
import '../../../common_utils/common_constants.dart';
import '../../../../core/network/api_service.dart';
import '../models/login_model.dart';
import '../repositories/login_repository.dart';

class LoginViewModel extends GetxController {
  final LoginRepository repository;

  // Resolves repository once on instantiation
  LoginViewModel({LoginRepository? repository})
      : repository = repository ??
            (Get.isRegistered<LoginRepository>()
                ? Get.find<LoginRepository>()
                : LoginRepositoryImpl(apiService: Get.find<ApiService>()));

  final emailController = TextEditingController(text: 'super-admin');
  final passwordController = TextEditingController(text: 'Nic@2025');
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final rememberMe = true.obs;
  final user = Rxn<LoginModel>();

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
      isLoading.value = true;

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

      final result = await repository.login(
        loginId: userName,
        password: password,
        salt: encryptedSalt,
      );

      result.fold(
        (failure) {
          CommonFunctions.errSnackbar(
            failure.message.isNotEmpty
                ? failure.message
                : "Invalid credentials",
            title: "Login Failed",
          );
        },
        (userData) {
          // Check backend business status code
          if (userData.code?.toUpperCase() == CommonConstants.successCode) {
            user.value = userData;
            debugPrint("Login Success: ${userData.accessToken}");
            Get.offAllNamed(Routes.home);
          } else {
            // Failure response from backend (e.g. Code == "F")
            final errorMsg = userData.message?.isNotEmpty == true
                ? userData.message!
                : "Invalid credentials. Please try again.";
            CommonFunctions.errSnackbar(
              errorMsg,
              title: "Login Failed",
            );
          }
        },
      );
    } catch (e) {
      CommonFunctions.errSnackbar(e.toString());
    } finally {
      isLoading.value = false;
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
