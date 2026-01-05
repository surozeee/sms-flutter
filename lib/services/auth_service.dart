import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  // Default credentials (in production, use secure storage or backend)
  static const String defaultUsername = 'admin';
  static const String defaultPassword = 'admin123';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _usernameKey = 'username';
  static const String _usersKey = 'registered_users';

  /// Register a new user
  static Future<bool> register({
    required String username,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get existing users
    final usersJson = prefs.getString(_usersKey);
    Map<String, String> users = {};
    
    if (usersJson != null) {
      users = Map<String, String>.from(json.decode(usersJson));
    }
    
    // Check if username already exists
    if (users.containsKey(username.toLowerCase())) {
      return false;
    }
    
    // Add new user (in production, hash the password)
    users[username.toLowerCase()] = password;
    
    // Save users
    await prefs.setString(_usersKey, json.encode(users));
    return true;
  }

  /// Login with username and password
  static Future<bool> login({
    required String username,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Check default credentials first
    if (username == defaultUsername && password == defaultPassword) {
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_usernameKey, username);
      return true;
    }
    
    // Check registered users
    final usersJson = prefs.getString(_usersKey);
    if (usersJson != null) {
      final users = Map<String, String>.from(json.decode(usersJson));
      final storedPassword = users[username.toLowerCase()];
      
      if (storedPassword != null && storedPassword == password) {
        // Save login state
        await prefs.setBool(_isLoggedInKey, true);
        await prefs.setString(_usernameKey, username);
        return true;
      }
    }
    
    return false;
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Get current username
  static Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  /// Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_usernameKey);
  }
}

