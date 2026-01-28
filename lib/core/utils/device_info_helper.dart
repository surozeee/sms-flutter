import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../services/fcm_token_cache_service.dart';

/// Helper class to get device information for API headers
class DeviceInfoHelper {
  static DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static PackageInfo? _packageInfo;
  static String? _deviceId;
  static String? _deviceName;
  static String? _osVersion;
  static String? _platform;
  static String? _appVersion;

  /// Initialize device info (call this once at app startup)
  static Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
    _appVersion = _packageInfo?.version ?? '0.0.1';

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      _deviceId = androidInfo.id;
      _deviceName = androidInfo.model;
      _osVersion = androidInfo.version.release;
      _platform = 'ANDROID';
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      _deviceId = iosInfo.identifierForVendor;
      _deviceName = iosInfo.name;
      _osVersion = iosInfo.systemVersion;
      _platform = 'IOS';
    } else {
      // Default values for other platforms
      _deviceId = 'unknown';
      _deviceName = 'unknown';
      _osVersion = 'unknown';
      _platform = 'UNKNOWN';
    }
  }

  /// Get device ID
  static String getDeviceId() => _deviceId ?? 'unknown';

  /// Get platform (ANDROID, IOS, etc.)
  static String getPlatform() => _platform ?? 'UNKNOWN';

  /// Get device name
  static String getDeviceName() => _deviceName ?? 'unknown';

  /// Get OS version
  static String getOsVersion() => _osVersion ?? 'unknown';

  /// Get app version (format: major.minor.patch)
  static String getAppVersion() => _appVersion ?? '0.0.1';

  /// Get app version in comma-separated format (e.g., "0,0,1")
  static String getAppVersionFormatted() {
    final version = getAppVersion();
    return version.replaceAll('.', ',');
  }

  /// Get all device headers as a map
  static Future<Map<String, String>> getDeviceHeaders({String? fcmToken}) async {
    // If FCM token not provided, try to get from cache
    String? token = fcmToken;
    if (token == null) {
      token = await FcmTokenCacheService.getFcmToken();
    }
    
    return {
      'Device-Id': getDeviceId(),
      'Platform': getPlatform(),
      'Fcm-Token': token ?? '1234', // Default if not provided
      'Device-Name': getDeviceName(),
      'Os-Version': getOsVersion(),
      'App-Version': getAppVersionFormatted(),
    };
  }
}
