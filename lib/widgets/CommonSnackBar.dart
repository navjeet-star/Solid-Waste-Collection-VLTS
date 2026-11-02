import 'package:flutter/material.dart';

class CommonSnackBar {
  static void show(BuildContext context, String message) {
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
