import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_profile.dart' show UserProfile, ProfileData, ProfileResponse;

/// Service to cache and retrieve user profile data
class ProfileCacheService {
  static const String _profileKey = 'cached_user_profile';
  static const String _profileDataKey = 'cached_profile_data';

  /// Save profile data to cache
  static Future<void> saveProfile(ProfileResponse profileResponse) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (profileResponse.data != null) {
      // Save user profile
      if (profileResponse.data!.user != null) {
        await prefs.setString(
          _profileKey,
          json.encode(profileResponse.data!.user!.toJson()),
        );
      }
      
      // Save full profile data (including balance, roleType)
      await prefs.setString(
        _profileDataKey,
        json.encode(profileResponse.data!.toJson()),
      );
    }
  }

  /// Get cached user profile
  static Future<UserProfile?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString(_profileKey);
    
    if (profileJson != null) {
      try {
        final profileMap = json.decode(profileJson) as Map<String, dynamic>;
        return UserProfile.fromJson(profileMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Get cached profile data (includes balance, roleType)
  static Future<ProfileData?> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final profileDataJson = prefs.getString(_profileDataKey);
    
    if (profileDataJson != null) {
      try {
        final profileDataMap = json.decode(profileDataJson) as Map<String, dynamic>;
        return ProfileData.fromJson(profileDataMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Get cached balance
  static Future<double> getBalance() async {
    final profileData = await getProfileData();
    return profileData?.balance ?? 0.0;
  }

  /// Get cached role type
  static Future<String?> getRoleType() async {
    final profileData = await getProfileData();
    return profileData?.roleType;
  }

  /// Clear cached profile data
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profileKey);
    await prefs.remove(_profileDataKey);
  }

  /// Check if profile is cached
  static Future<bool> hasCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_profileKey);
  }
}
