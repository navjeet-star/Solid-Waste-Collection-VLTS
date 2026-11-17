/// Centralized API Endpoints, Base URLs, and Network Configuration.
class ApiEndpoints {
  ApiEndpoints._();

  // Active Base URL (Local PC)
  static const String appBaseUrl = "https://192.168.137.1:44365/";

  // Alternative Local / Production URLs for quick switching:
  // static const String appBaseUrl = "https://192.168.29.141:44365/"; // Local PC (Wi-Fi IP)
  // static const String appBaseUrl = "https://10.0.2.2:44365/";       // Android Emulator host loopback
  // static const String appBaseUrl = "https://vlts-udd.uk.gov.in/";    // Production / Staging Server

  // Auth API Endpoint Base
  static const String authApiBase = "${appBaseUrl}api/AuthApi/";

  // Timeouts (milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
}
