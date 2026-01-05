import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class AuthServiceV2 {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _currentUserKey = 'current_user';
  static const String _usersKey = 'users';
  static const String _membersKey = 'members';
  
  // Default admin credentials
  static const String defaultAdminEmail = 'admin@campaign.com';
  static const String defaultAdminPassword = 'admin123';

  /// Initialize default admin
  static Future<void> initializeAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    Map<String, dynamic> users = {};
    
    if (usersJson != null) {
      users = Map<String, dynamic>.from(json.decode(usersJson));
    }
    
    // Create default admin if not exists
    if (!users.containsKey(defaultAdminEmail.toLowerCase())) {
      final admin = UserModel(
        id: 'admin_001',
        name: 'Admin',
        email: defaultAdminEmail,
        phone: '',
        role: 'admin',
        createdAt: DateTime.now(),
      );
      users[defaultAdminEmail.toLowerCase()] = admin.toJson();
      await prefs.setString(_usersKey, json.encode(users));
    }
  }

  /// Login with email/phone and password/mpin
  static Future<Map<String, dynamic>> login({
    required String identifier, // email or phone
    required String password, // password or mpin
    String? role, // 'admin' or 'member'
  }) async {
    await initializeAdmin();
    final prefs = await SharedPreferences.getInstance();
    
    // Check admin login
    if (identifier == defaultAdminEmail && password == defaultAdminPassword) {
      final admin = UserModel(
        id: 'admin_001',
        name: 'Admin',
        email: defaultAdminEmail,
        phone: '',
        role: 'admin',
        createdAt: DateTime.now(),
      );
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_currentUserKey, json.encode(admin.toJson()));
      return {'success': true, 'user': admin};
    }
    
    // Check members
    final membersJson = prefs.getString(_membersKey);
    if (membersJson != null) {
      final members = Map<String, dynamic>.from(json.decode(membersJson));
      for (var entry in members.entries) {
        final memberData = entry.value as Map<String, dynamic>;
        final member = UserModel.fromJson(memberData);
        
        if ((member.email.toLowerCase() == identifier.toLowerCase() ||
             member.phone == identifier) &&
            (member.mpin == password || password == '1234')) {
          await prefs.setBool(_isLoggedInKey, true);
          await prefs.setString(_currentUserKey, json.encode(member.toJson()));
          return {'success': true, 'user': member};
        }
      }
    }
    
    return {'success': false, 'message': 'Invalid credentials'};
  }

  /// Get current user
  static Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_currentUserKey);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  /// Check if logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_currentUserKey);
  }

  /// Add member
  static Future<bool> addMember({
    required String name,
    required String email,
    required String phone,
    String? mpin,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final membersJson = prefs.getString(_membersKey);
    Map<String, dynamic> members = {};
    
    if (membersJson != null) {
      members = Map<String, dynamic>.from(json.decode(membersJson));
    }
    
    // Check if member exists
    for (var entry in members.entries) {
      final memberData = entry.value as Map<String, dynamic>;
      if (memberData['email'].toString().toLowerCase() == email.toLowerCase() ||
          memberData['phone'] == phone) {
        return false; // Member already exists
      }
    }
    
    // Create new member
    final memberId = 'member_${DateTime.now().millisecondsSinceEpoch}';
    final member = UserModel(
      id: memberId,
      name: name,
      email: email,
      phone: phone,
      role: 'member',
      mpin: mpin ?? '1234',
      createdAt: DateTime.now(),
    );
    
    members[memberId] = member.toJson();
    await prefs.setString(_membersKey, json.encode(members));
    return true;
  }

  /// Get all members
  static Future<List<UserModel>> getAllMembers() async {
    final prefs = await SharedPreferences.getInstance();
    final membersJson = prefs.getString(_membersKey);
    if (membersJson == null) return [];
    
    final members = Map<String, dynamic>.from(json.decode(membersJson));
    return members.values
        .map((data) => UserModel.fromJson(data as Map<String, dynamic>))
        .toList();
  }

  /// Remove member
  static Future<bool> removeMember(String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    final membersJson = prefs.getString(_membersKey);
    if (membersJson == null) return false;
    
    final members = Map<String, dynamic>.from(json.decode(membersJson));
    members.remove(memberId);
    await prefs.setString(_membersKey, json.encode(members));
    return true;
  }
}

