import 'package:flutter/services.dart';

class ScreenProtectionUtils {
  // Create a static method to disable screenshots
  static const platform = MethodChannel('com.example/secure_screen');

  // Method to disable screenshots
  static Future<void> disableScreenshot() async {
    try {
      await platform.invokeMethod('disableScreenshot');
    } on PlatformException catch (e) {
      print("Failed to disable screenshot: '${e.message}'.");
    }
  }
}
