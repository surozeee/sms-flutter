import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SmsGatewayService {
  static const String _balanceKey = 'sms_gateway_balance';
  static const String _packageHistoryKey = 'package_history';
  
  // SMS costs per carrier (in NPR)
  static const Map<String, double> smsCosts = {
    'NTC': 0.50,
    'Ncell': 0.50,
    'Smart': 0.50,
    'Unknown': 0.50,
  };

  /// Get current balance
  static Future<double> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_balanceKey) ?? 0.0;
  }

  /// Add balance (purchase package)
  static Future<bool> purchasePackage(double amount) async {
    final prefs = await SharedPreferences.getInstance();
    final currentBalance = await getBalance();
    final newBalance = currentBalance + amount;
    
    await prefs.setDouble(_balanceKey, newBalance);
    
    // Save to history
    final historyJson = prefs.getString(_packageHistoryKey);
    List<Map<String, dynamic>> history = [];
    if (historyJson != null) {
      history = List<Map<String, dynamic>>.from(json.decode(historyJson));
    }
    
    history.add({
      'amount': amount,
      'date': DateTime.now().toIso8601String(),
      'balanceAfter': newBalance,
    });
    
    await prefs.setString(_packageHistoryKey, json.encode(history));
    return true;
  }

  /// Deduct balance for SMS
  static Future<bool> deductBalance(String carrier, int smsCount) async {
    final cost = smsCosts[carrier] ?? 0.50;
    final totalCost = cost * smsCount;
    final balance = await getBalance();
    
    if (balance >= totalCost) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_balanceKey, balance - totalCost);
      return true;
    }
    return false;
  }

  /// Get package history
  static Future<List<Map<String, dynamic>>> getPackageHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_packageHistoryKey);
    if (historyJson == null) return [];
    
    return List<Map<String, dynamic>>.from(json.decode(historyJson));
  }

  /// Calculate cost for SMS
  static double calculateCost(String carrier, int smsCount) {
    final cost = smsCosts[carrier] ?? 0.50;
    return cost * smsCount;
  }

  /// Get SMS costs display
  static Map<String, double> getSmsCosts() {
    return smsCosts;
  }
}

