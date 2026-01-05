import 'package:flutter_sms/flutter_sms.dart';
import '../models/contact_model.dart';
import 'stats_service.dart';

class SmsService {
  static Future<Map<String, dynamic>> sendBulkSms({
    required List<ContactModel> contacts,
    required String message,
  }) async {
    List<String> recipients = contacts
        .where((contact) => contact.isSelected)
        .map((contact) => contact.phoneNumber)
        .toList();

    if (recipients.isEmpty) {
      return {
        'success': false,
        'message': 'No contacts selected',
        'sentCount': 0,
        'failedCount': 0,
      };
    }

    int sentCount = 0;
    int failedCount = 0;
    List<String> failedNumbers = [];

    try {
      String result = await sendSMS(
        message: message,
        recipients: recipients,
        sendDirect: true,
      );

      // Parse result to determine success/failure
      if (result.contains('sent')) {
        sentCount = recipients.length;
        // Update statistics
        await StatsService.incrementSmsCount(sentCount);
      } else {
        failedCount = recipients.length;
        failedNumbers = recipients;
      }
    } catch (e) {
      failedCount = recipients.length;
      failedNumbers = recipients;
      return {
        'success': false,
        'message': 'Error sending SMS: $e',
        'sentCount': sentCount,
        'failedCount': failedCount,
        'failedNumbers': failedNumbers,
      };
    }

    return {
      'success': sentCount > 0,
      'message': 'SMS sent to $sentCount recipients',
      'sentCount': sentCount,
      'failedCount': failedCount,
      'failedNumbers': failedNumbers,
    };
  }

  static Future<void> sendSmsToSingle({
    required String phoneNumber,
    required String message,
  }) async {
    try {
      await sendSMS(
        message: message,
        recipients: [phoneNumber],
        sendDirect: true,
      );
    } catch (e) {
      throw Exception('Failed to send SMS: $e');
    }
  }
}

