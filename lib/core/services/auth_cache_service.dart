import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Service to cache and retrieve login authentication data
class AuthCacheService {
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _userTypeKey = 'auth_user_type';
  static const String _isLoggedInKey = 'auth_is_logged_in';
  static const String _loginDataKey = 'auth_login_data';

  /// Save login data to cache
  static Future<void> saveLoginData({
    required String accessToken,
    required String refreshToken,
    required String userType,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_userTypeKey, userType);
    await prefs.setBool(_isLoggedInKey, true);
    
    // Also save as JSON for easy retrieval
    final loginData = {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userType': userType,
      'savedAt': DateTime.now().toIso8601String(),
    };
    await prefs.setString(_loginDataKey, json.encode(loginData));
  }

  /// Get cached access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  /// Get cached refresh token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  /// Get cached user type
  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  /// Check if user is logged in (has cached tokens)
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    final accessToken = prefs.getString(_accessTokenKey);
    
    // Return true only if both flag and token exist
    return isLoggedIn && accessToken != null && accessToken.isNotEmpty;
  }

  /// Get all cached login data as a map
  static Future<Map<String, String?>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'accessToken': prefs.getString(_accessTokenKey),
      'refreshToken': prefs.getString(_refreshTokenKey),
      'userType': prefs.getString(_userTypeKey),
    };
  }

  /// Clear all cached login data (logout)
  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userTypeKey);
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_loginDataKey);
  }

  /// Update access token (useful for token refresh)
  static Future<void> updateAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    
    // Update in JSON data as well
    final loginDataJson = prefs.getString(_loginDataKey);
    if (loginDataJson != null) {
      final loginData = json.decode(loginDataJson) as Map<String, dynamic>;
      loginData['accessToken'] = accessToken;
      loginData['updatedAt'] = DateTime.now().toIso8601String();
      await prefs.setString(_loginDataKey, json.encode(loginData));
    }
  }

  /// Update refresh token
  static Future<void> updateRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, refreshToken);
    
    // Update in JSON data as well
    final loginDataJson = prefs.getString(_loginDataKey);
    if (loginDataJson != null) {
      final loginData = json.decode(loginDataJson) as Map<String, dynamic>;
      loginData['refreshToken'] = refreshToken;
      await prefs.setString(_loginDataKey, json.encode(loginData));
    }
  }
}
