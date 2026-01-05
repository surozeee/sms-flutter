import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const String _smsSentCountKey = 'sms_sent_count';
  static const String _todaySentCountKey = 'today_sent_count';
  static const String _lastResetDateKey = 'last_reset_date';

  /// Get total SMS sent count
  static Future<int> getSmsSentCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_smsSentCountKey) ?? 0;
  }

  /// Get today's SMS sent count
  static Future<int> getTodaySentCount() async {
    final prefs = await SharedPreferences.getInstance();
    final lastResetDate = prefs.getString(_lastResetDateKey);
    final today = DateTime.now().toIso8601String().split('T')[0];

    // Reset if it's a new day
    if (lastResetDate != today) {
      await prefs.setString(_lastResetDateKey, today);
      await prefs.setInt(_todaySentCountKey, 0);
      return 0;
    }

    return prefs.getInt(_todaySentCountKey) ?? 0;
  }

  /// Increment SMS sent count
  static Future<void> incrementSmsCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Update total count
    final currentTotal = prefs.getInt(_smsSentCountKey) ?? 0;
    await prefs.setInt(_smsSentCountKey, currentTotal + count);

    // Update today's count
    final lastResetDate = prefs.getString(_lastResetDateKey);
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (lastResetDate != today) {
      await prefs.setString(_lastResetDateKey, today);
      await prefs.setInt(_todaySentCountKey, count);
    } else {
      final currentToday = prefs.getInt(_todaySentCountKey) ?? 0;
      await prefs.setInt(_todaySentCountKey, currentToday + count);
    }
  }

  /// Reset all statistics
  static Future<void> resetStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_smsSentCountKey);
    await prefs.remove(_todaySentCountKey);
    await prefs.remove(_lastResetDateKey);
  }
}

