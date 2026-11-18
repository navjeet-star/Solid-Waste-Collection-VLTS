import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/routes/app_pages.dart';
import '../../features/login/models/login_model.dart';


class SharedPrefsService {
  SharedPrefsService._();

  static SharedPrefsService? _instance;
  static SharedPrefsService get instance => _instance ??= SharedPrefsService._();

  SharedPreferences? _prefs;
  Future<SharedPreferences> get _storage async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // --- Keys ---
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyLoginResponseRaw = 'login_response_raw';
  static const String keyIsFirstLaunch = 'is_first_launch';

  // Individual Profile Keys
  static const String keyLoginId = 'user_login_id';
  static const String keyName = 'user_name';
  static const String keyMobileNo = 'user_mobile_no';
  static const String keyRoleId = 'user_role_id';
  static const String keyRoleName = 'user_role_name';
  static const String keyUserLevelId = 'user_user_level_id';
  static const String keyUserLevel = 'user_user_level';
  static const String keyDistrictId = 'user_district_id';
  static const String keyDistrict = 'user_district';
  static const String keyUlbId = 'user_ulb_id';
  static const String keyUlb = 'user_ulb';
  static const String keyWardId = 'user_ward_id';
  static const String keyWard = 'user_ward';
  static const String keyDesignation = 'user_designation';
  static const String keyEmailId = 'user_email_id';
  static const String keyEmployeeId = 'user_employee_id';

  Future<void> saveLoginResponse(LoginModel loginModel) async {
    final prefs = await _storage;

    // 1. Save Raw JSON
    try {
      final rawJson = jsonEncode(loginModel.toJson());
      await prefs.setString(keyLoginResponseRaw, rawJson);
    } catch (_) {}

    // 2. Save Tokens separately
    if (loginModel.accessToken != null) {
      await prefs.setString(keyAccessToken, loginModel.accessToken!);
    }
    if (loginModel.refreshToken != null) {
      await prefs.setString(keyRefreshToken, loginModel.refreshToken!);
    }

    // 3. Save Profile Detail fields individually
    final profile = loginModel.profileDetail;
    if (profile != null) {
      await _saveString(prefs, keyLoginId, profile.loginID);
      await _saveString(prefs, keyName, profile.name);
      await _saveString(prefs, keyMobileNo, profile.mobileNo);
      await _saveString(prefs, keyRoleId, profile.roleID);
      await _saveString(prefs, keyRoleName, profile.roleName);
      await _saveString(prefs, keyUserLevelId, profile.userLevelID);
      await _saveString(prefs, keyUserLevel, profile.userLevel);
      await _saveString(prefs, keyDistrictId, profile.districtID);
      await _saveString(prefs, keyDistrict, profile.district);
      await _saveString(prefs, keyUlbId, profile.ulbid);
      await _saveString(prefs, keyUlb, profile.ulb);
      await _saveString(prefs, keyWardId, profile.wardID);
      await _saveString(prefs, keyWard, profile.ward);
      await _saveString(prefs, keyDesignation, profile.designation);
      await _saveString(prefs, keyEmailId, profile.emailID);
      await _saveString(prefs, keyEmployeeId, profile.employeeID);
    }

    // 4. Mark user as authenticated
    await prefs.setBool(keyIsLoggedIn, true);
  }

  /// Helper to safely store or remove null strings
  Future<void> _saveString(SharedPreferences prefs, String key, String? value) async {
    if (value != null && value.isNotEmpty) {
      await prefs.setString(key, value);
    } else {
      await prefs.remove(key);
    }
  }

  /// Retrieves the saved [LoginModel] from local storage, or null if none saved.
  Future<LoginModel?> getLoginResponse() async {
    final prefs = await _storage;
    final rawJson = prefs.getString(keyLoginResponseRaw);
    if (rawJson == null || rawJson.isEmpty) {
      return null;
    }
    try {
      final map = jsonDecode(rawJson) as Map<String, dynamic>;
      return LoginModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  /// Retrieves the stored access token.
  Future<String?> getAccessToken() async {
    final prefs = await _storage;
    return prefs.getString(keyAccessToken);
  }

  /// Retrieves the stored refresh token.
  Future<String?> getRefreshToken() async {
    final prefs = await _storage;
    return prefs.getString(keyRefreshToken);
  }

  /// Retrieves the stored refresh token.
  Future<String?> getLoginID() async {
    final prefs = await _storage;
    return prefs.getString(keyLoginId);
  }

  /// Checks if the user is currently logged in.
  Future<bool> isLoggedIn() async {
    final prefs = await _storage;
    final loggedIn = prefs.getBool(keyIsLoggedIn) ?? false;
    final token = prefs.getString(keyAccessToken);
    return loggedIn && token != null && token.isNotEmpty;
  }

  /// Retrieves all 16 profile fields as a convenient Map.
  Future<Map<String, String?>> getUserProfile() async {
    final prefs = await _storage;
    return {
      'LoginID': prefs.getString(keyLoginId),
      'Name': prefs.getString(keyName),
      'MobileNo': prefs.getString(keyMobileNo),
      'RoleID': prefs.getString(keyRoleId),
      'RoleName': prefs.getString(keyRoleName),
      'UserLevelID': prefs.getString(keyUserLevelId),
      'UserLevel': prefs.getString(keyUserLevel),
      'DistrictID': prefs.getString(keyDistrictId),
      'District': prefs.getString(keyDistrict),
      'ULBID': prefs.getString(keyUlbId),
      'ULB': prefs.getString(keyUlb),
      'WardID': prefs.getString(keyWardId),
      'Ward': prefs.getString(keyWard),
      'Designation': prefs.getString(keyDesignation),
      'EmailID': prefs.getString(keyEmailId),
      'EmployeeID': prefs.getString(keyEmployeeId),
    };
  }

  /// Checks if this is the first time the app is launched after installation (defaults to true).
  Future<bool> isFirstLaunch() async {
    final prefs = await _storage;
    return prefs.getBool(keyIsFirstLaunch) ?? true;
  }

  /// Marks the initial overview / onboarding flow as completed.
  Future<void> setFirstLaunchComplete() async {
    final prefs = await _storage;
    await prefs.setBool(keyIsFirstLaunch, false);
  }

  /// Clears all user session, profile, and token data (e.g. on logout).
  Future<void> clearAll() async {
    final prefs = await _storage;
    await prefs.remove(keyAccessToken);
    await prefs.remove(keyRefreshToken);
    await prefs.remove(keyIsLoggedIn);
    await prefs.remove(keyLoginResponseRaw);
    await prefs.remove(keyLoginId);
    await prefs.remove(keyName);
    await prefs.remove(keyMobileNo);
    await prefs.remove(keyRoleId);
    await prefs.remove(keyRoleName);
    await prefs.remove(keyUserLevelId);
    await prefs.remove(keyUserLevel);
    await prefs.remove(keyDistrictId);
    await prefs.remove(keyDistrict);
    await prefs.remove(keyUlbId);
    await prefs.remove(keyUlb);
    await prefs.remove(keyWardId);
    await prefs.remove(keyWard);
    await prefs.remove(keyDesignation);
    await prefs.remove(keyEmailId);
    await prefs.remove(keyEmployeeId);
  }

  /// Clears user session and redirects to the Login screen.
  Future<void> logout() async {
    await clearAll();
    Get.offAllNamed(Routes.login);
  }
}

