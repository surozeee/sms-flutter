import 'package:flutter/services.dart';
import '../models/contact_model.dart';
import 'stats_service.dart';

class SmsService {
  static const MethodChannel _channel = MethodChannel('sms_service');

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
      // Send SMS to each recipient
      for (String recipient in recipients) {
        try {
          final result = await _channel.invokeMethod('sendSms', {
            'phoneNumber': recipient,
            'message': message,
          });
          if (result == true || result == 'sent') {
            sentCount++;
          } else {
            failedCount++;
            failedNumbers.add(recipient);
          }
        } catch (e) {
          failedCount++;
          failedNumbers.add(recipient);
        }
      }

      // Update statistics
      if (sentCount > 0) {
        await StatsService.incrementSmsCount(sentCount);
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
      await _channel.invokeMethod('sendSms', {
        'phoneNumber': phoneNumber,
        'message': message,
      });
    } catch (e) {
      throw Exception('Failed to send SMS: $e');
    }
  }
}

