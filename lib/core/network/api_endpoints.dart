/// Centralized API Endpoints, Base URLs, and Network Configuration.
class ApiEndpoints {
  ApiEndpoints._();

  // Base URLs
  static const String appBaseUrl = "https://vlts-udd.uk.gov.in/";
  // static const String appBaseUrl = "https://dummyjson.com/";
  static const String authApiBase = "${appBaseUrl}api/AuthApi/";
  // static const String authApiBase = "${appBaseUrl}";


  // Timeouts (milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

}

