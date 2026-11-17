import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/core/services/shared_prefs_service.dart';

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

  /// Displays a reusable confirmation popup dialog.
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    String title = 'Confirmation',
    String message = 'Are you sure you want to proceed?',
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: colorScheme.surface,
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        actionsPadding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        title: Row(
          children: [

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              cancelText,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            onPressed: () {
              Navigator.of(ctx).pop(true);
              onConfirm?.call();
            },
            child: Text(
              confirmText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// Common popup to verify logout with user confirmation.
  static Future<void> showLogoutDialog(BuildContext context) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      cancelText: 'Cancel',
    );

    if (confirmed == true) {
      await SharedPrefsService.instance.logout();
    }
  }
}

/// Backwards-compatibility alias for typo 'CommonFuntions'
typedef CommonFuntions = CommonFunctions;

/// Standalone global helper function for error snackbars
void errSnackbar(String message, {String title = "Error"}) {
  CommonFunctions.errSnackbar(message, title: title);
}




