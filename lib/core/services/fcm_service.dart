import 'package:firebase_messaging/firebase_messaging.dart';
import 'fcm_token_cache_service.dart';

/// Service to handle Firebase Cloud Messaging (FCM) operations
class FcmService {
  static FirebaseMessaging? _firebaseMessaging;

  /// Initialize Firebase Messaging and get token
  static Future<String?> initializeAndGetToken() async {
    try {
      _firebaseMessaging = FirebaseMessaging.instance;

      // Request permission for iOS
      final settings = await _firebaseMessaging!.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Get the token
        final token = await _firebaseMessaging!.getToken();
        
        if (token != null) {
          // Save token to cache
          await FcmTokenCacheService.saveFcmToken(token);
          
          // Listen for token refresh
          _firebaseMessaging!.onTokenRefresh.listen((newToken) async {
            await FcmTokenCacheService.saveFcmToken(newToken);
          });
          
          return token;
        }
      }
      
      return null;
    } catch (e) {
      print('Error initializing FCM: $e');
      return null;
    }
  }

  /// Get current FCM token (from cache or request new one)
  static Future<String?> getToken() async {
    try {
      // First try to get from cache
      final cachedToken = await FcmTokenCacheService.getFcmToken();
      if (cachedToken != null && cachedToken.isNotEmpty) {
        return cachedToken;
      }

      // If no cached token, initialize and get new token
      return await initializeAndGetToken();
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  /// Refresh FCM token
  static Future<String?> refreshToken() async {
    try {
      _firebaseMessaging ??= FirebaseMessaging.instance;
      final token = await _firebaseMessaging!.getToken();
      
      if (token != null) {
        await FcmTokenCacheService.saveFcmToken(token);
      }
      
      return token;
    } catch (e) {
      print('Error refreshing FCM token: $e');
      return null;
    }
  }

  /// Get Firebase Messaging instance
  static FirebaseMessaging? get instance => _firebaseMessaging;

  /// Setup foreground message handler
  static void setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  /// Setup background message handler (must be top-level function)
  static Future<void> setupBackgroundMessageHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    print('Message data: ${message.data}');
  }
}
