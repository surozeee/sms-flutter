import 'package:shared_preferences/shared_preferences.dart';

/// Service to cache and retrieve FCM (Firebase Cloud Messaging) token
class FcmTokenCacheService {
  static const String _fcmTokenKey = 'fcm_token';
  static const String _fcmTokenTimestampKey = 'fcm_token_timestamp';

  /// Save FCM token to cache
  static Future<void> saveFcmToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmTokenKey, token);
    await prefs.setString(_fcmTokenTimestampKey, DateTime.now().toIso8601String());
  }

  /// Get cached FCM token
  static Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmTokenKey);
  }

  /// Get FCM token timestamp
  static Future<DateTime?> getFcmTokenTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    final timestampStr = prefs.getString(_fcmTokenTimestampKey);
    if (timestampStr != null) {
      try {
        return DateTime.parse(timestampStr);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Clear cached FCM token
  static Future<void> clearFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmTokenKey);
    await prefs.remove(_fcmTokenTimestampKey);
  }

  /// Check if FCM token is cached
  static Future<bool> hasCachedFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_fcmTokenKey);
  }
}
