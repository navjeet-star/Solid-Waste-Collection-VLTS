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

  /// Displays an Android/iOS native-style floating capsule toast.
  static void showToast(
    String message, {
    bool isError = true,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (Get.context == null) return;

    if (Get.isSnackbarOpen == true) {
      Get.closeCurrentSnackbar();
    }

    Get.rawSnackbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: isError
          ? const Color(0xE6212121)
          : const Color(0xE61B8E56),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 25,
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 36),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: duration,
      animationDuration: const Duration(milliseconds: 250),
      snackStyle: SnackStyle.FLOATING,
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

  /// Displays a full-screen modal loading dialog that blocks user interaction.
  static void showLoader({String? message}) {
    if (Get.isDialogOpen == true) return;
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Get.theme.colorScheme.primary,
                ),
                if (message != null && message.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Get.theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.4),
    );
  }

  /// Closes the full-screen loading dialog if it is open.
  static void hideLoader() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  /// Builds a full-screen loading overlay widget designed for Stack layouts.
  static Widget loadingOverlay({
    required bool isLoading,
    BuildContext? context,
  }) {
    if (!isLoading) {
      return const IgnorePointer(child: SizedBox.shrink());
    }

    final theme = context != null ? Theme.of(context) : Get.theme;
    final colorScheme = theme.colorScheme;

    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.4),
        alignment: Alignment.center,
        child: Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable full-screen loading overlay wrapper widget
class CommonLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CommonLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        CommonFunctions.loadingOverlay(
          isLoading: isLoading,
          context: context,
        ),
      ],
    );
  }
}

/// Standalone global helper functions for loaders
void showLoader({String? message}) => CommonFunctions.showLoader(message: message);
void hideLoader() => CommonFunctions.hideLoader();

/// Backwards-compatibility alias for typo 'CommonFuntions'
typedef CommonFuntions = CommonFunctions;

/// Standalone global helper function for error snackbars
void errSnackbar(String message, {String title = "Error"}) {
  CommonFunctions.errSnackbar(message, title: title);
}

/// Standalone global helper function for toasts
void showToast(String message, {bool isError = true}) {
  CommonFunctions.showToast(message, isError: isError);
}

/// Android-style logging utility for Flutter developers
class Log {
  Log._();

  /// Debug log
  static void d(String tag, dynamic message) {
    debugPrint("[$tag] (DEBUG): $message");
  }

  /// Info log
  static void i(String tag, dynamic message) {
    debugPrint("[$tag] (INFO): $message");
  }

  /// Warning log
  static void w(String tag, dynamic message) {
    debugPrint("[$tag] (WARN): $message");
  }

  /// Error log
  static void e(String tag, dynamic message) {
    debugPrint("[$tag] (ERROR): $message");
  }
}





