
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlts_swc/features/login/models/LoginModel.dart';
import 'package:vlts_swc/features/login/models/ProfileDetail.dart';

import 'secure_storage_service.dart';

class SharedPrefsService {
  SharedPrefsService._();

  static SharedPreferences? _prefs;

  static const String _loginResponseKey = 'login_response';
  static const String _profileKey = 'user_profile';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _isFirstLaunchKey = 'is_first_launch';

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    if (_prefs == null) {
      throw Exception(
        'SharedPrefsService not initialized. Call init() first.',
      );
    }
    return _prefs!;
  }

  // ==========================================
  // SAVE LOGIN RESPONSE
  // ==========================================

  static Future<void> saveLoginResponse(
      LoginModel response,
      ) async {
    if (response.code != 'S') {
      throw Exception(response.message ?? 'Login failed.');
    }

    final tokens = response.tokens;
    final profile = response.profileDetail;

    if (tokens == null || profile == null) {
      throw Exception('Login response is incomplete.');
    }

    final accessToken = tokens.accessToken;
    final refreshToken = tokens.refreshToken;

    if (accessToken == null ||
        accessToken.isEmpty ||
        refreshToken == null ||
        refreshToken.isEmpty) {
      throw Exception('Authentication tokens are missing.');
    }

    // Save tokens securely
    await SecureStorageService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    // Save login response without duplicating tokens
    final responseJson = response.toJson();
    responseJson.remove('Tokens');

    final profileJson =
    responseJson['ProfileDetail'] as Map<String, dynamic>?;

    profileJson?.remove('RefreshToken');

    await _instance.setString(
      _loginResponseKey,
      jsonEncode(responseJson),
    );

    // Save complete profile
    await saveProfile(profile);

    // Update login status
    await _instance.setBool(_isLoggedInKey, true);
  }

  // ==========================================
  // SAVE COMPLETE PROFILE
  // ==========================================

  static Future<void> saveProfile(
      ProfileDetail profile,
      ) async {
    final profileJson = profile.toJson()
      ..remove('RefreshToken');

    await _instance.setString(
      _profileKey,
      jsonEncode(profileJson),
    );
  }

  // ==========================================
  // GET COMPLETE LOGIN RESPONSE
  // ==========================================

  static Future<LoginModel?> getLoginResponse() async {
    final data = _instance.getString(_loginResponseKey);

    if (data == null || data.isEmpty) {
      return null;
    }

    return LoginModel.fromJson(
      jsonDecode(data) as Map<String, dynamic>,
    );
  }

  // ==========================================
  // GET COMPLETE PROFILE
  // ==========================================

  static Future<ProfileDetail?> getProfile() async {
    final data = _instance.getString(_profileKey);

    if (data == null || data.isEmpty) {
      return null;
    }

    return ProfileDetail.fromJson(
      jsonDecode(data) as Map<String, dynamic>,
    );
  }

  // ==========================================
  // GET TOKENS
  // ==========================================

  static Future<String?> getAccessToken() async {
    return SecureStorageService.getAccessToken();
  }

  static Future<String?> getRefreshToken() async {
    return SecureStorageService.getRefreshToken();
  }

  // ==========================================
  // LOGIN STATUS
  // ==========================================

  static bool get isLoggedIn {
    return _instance.getBool(_isLoggedInKey) ?? false;
  }

  static bool get isFirstLaunch {
    return _instance.getBool(_isFirstLaunchKey) ?? true;
  }

  static Future<void> setFirstLaunch(bool value) async {
    await _instance.setBool(_isFirstLaunchKey, value);
  }

  // Mark first launch as completed
  static Future<void> setFirstLaunchComplete() async {
    await _instance.setBool(_isFirstLaunchKey, false);
  }
  // ==========================================
  // LOGOUT
  // ==========================================

  static Future<void> logout() async {
    // Clear secure tokens
    await SecureStorageService.clearTokens();

    // Clear saved profile and login response
    await _instance.remove(_loginResponseKey);
    await _instance.remove(_profileKey);
    await _instance.remove(_isLoggedInKey);

    // First-launch preference is intentionally preserved.
  }
}
