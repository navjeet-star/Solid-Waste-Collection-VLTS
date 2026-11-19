/// Centralized API Endpoints, Base URLs, and Network Configuration.
class ApiEndpoints {
  ApiEndpoints._();

  // Root Server Domain (Switch here between Local, Staging, and Production)
  static const String serverBaseUrl = "https://192.168.137.1:44365/";

  // Alternative Local / Production URLs for quick switching:
  // static const String serverBaseUrl = "https://192.168.29.141:44365/"; // Local PC (Wi-Fi IP)
  // static const String serverBaseUrl = "https://10.0.2.2:44365/";       // Android Emulator host loopback
  // static const String serverBaseUrl = "https://vlts-udd.uk.gov.in/";    // Production / Staging Server

  // -------------------------------------------------------------
  // Service Module Base URLs
  // -------------------------------------------------------------
  static const String authApi = "${serverBaseUrl}api/AuthApi/";
  static const String officeApi = "${serverBaseUrl}api/OfficeApi/";
  static const String masterApi = "${serverBaseUrl}api/MasterApi/";

  // -------------------------------------------------------------
  // 1. Auth Module Endpoints (Defined in ONE place only)
  // -------------------------------------------------------------
  static const String departmentUserAuth = "${authApi}DepartmentUserAuthentication";
  static const String uLBWiseProgressList = "${authApi}ULBWiseProgressList";


  // -------------------------------------------------------------
  // 2. Office Module Endpoints
  // -------------------------------------------------------------
  static const String getOfficeDetails = "${officeApi}GetOfficeDetails";
  static const String getWardList = "${officeApi}GetWardList";

  // -------------------------------------------------------------
  // 3. Master Module Endpoints
  // -------------------------------------------------------------
  static const String getVehicleTypes = "${masterApi}GetVehicleTypes";
  static const String getBinCategories = "${masterApi}GetBinCategories";

  // Timeouts (milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Backwards-compatibility alias for previous references
  static const String appBaseUrl = serverBaseUrl;
  static const String authApiBase = authApi;
}
