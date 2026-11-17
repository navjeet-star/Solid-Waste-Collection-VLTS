/// Centralized common application and API constants.
class CommonConstants {
  CommonConstants._();

  /// API Response Status Codes
  static const String success = "S";
  static const String successCode = "S";
  static const String failure = "F";
  static const String failureCode = "F";

  /// General Titles
  static const String successTitle = "Success";
  static const String errorTitle = "Error";
  static const String loginFailedTitle = "Login Failed";
}

/// Top-level constant for direct access
const String successCode = CommonConstants.successCode;
const String failureCode = CommonConstants.failureCode;

