import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Centralized utility class for common operations (snackbars, dialogs, helpers).
class CommonFunctions {
  CommonFunctions._();

  /// Displays an error snackbar at the bottom of the screen.
  static void errSnackbar(
    String message, {
    String title = "Error",
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  /// Displays a success snackbar at the bottom of the screen.
  static void successSnackbar(
    String message, {
    String title = "Success",
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  /// Displays a standard ScaffoldMessenger snackbar with BuildContext.
  static void showSnackBar(BuildContext context, String message) {
    final colorScheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Backwards-compatibility alias for typo 'CommonFuntions'
typedef CommonFuntions = CommonFunctions;

/// Standalone global helper function for error snackbars
void errSnackbar(String message, {String title = "Error"}) {
  CommonFunctions.errSnackbar(message, title: title);
}

