import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_pages.dart';
import '../../../../core/aes_encypt.dart';
import '../models/login_model.dart';
import '../repositories/login_repository.dart';

class LoginViewModel extends GetxController {
  final LoginRepository? repository;

  LoginViewModel({this.repository});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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

      // Resolve repository from parameter or GetX container
      final repo = repository ??
          (Get.isRegistered<LoginRepository>()
              ? Get.find<LoginRepository>()
              : null);

      if (repo == null) {
        throw Exception("LoginRepository is not registered.");
      }

      // Initialize encryption helper
      final encryptionHelper = AESENCRYPTION();

      // Encrypt loginId, passwordForApi, and salt separately
      String salt, password, userName;
      salt = encryptionHelper.getSalt(5);

      userName = encryptionHelper.aesEncryption(plainText: emailController.text.toString());
      password = encryptionHelper.aesEncryption(plainText: encryptionHelper.getSha256(passwordController.text.toString()+salt));
      salt = encryptionHelper.aesEncryption(plainText: salt);

      final result = await repo.login(
        loginId: base64Url.encode(utf8.encode(userName)),
        password: base64Url.encode(utf8.encode(password)),
        salt: base64Url.encode(utf8.encode(salt)),
      );

      result.fold(
        (failure) {
          Get.snackbar(
            "Login Failed",
            failure.message.isNotEmpty ? failure.message : "Invalid credentials",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (userData) {
          user.value = userData;
          debugPrint("Login Success: ${userData.accessToken}");
          Get.offAllNamed(Routes.home);
        },
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
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

