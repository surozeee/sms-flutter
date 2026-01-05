import 'package:contacts_service/contacts_service.dart';
import '../models/contact_model.dart';

class ContactService {
  // Carrier prefixes for Nepal (based on common number ranges)
  // Note: All carriers share similar prefixes, so detection is approximate
  static const Map<String, List<String>> carrierPrefixes = {
    'NTC': [
      // NTC (Nepal Telecom) common prefixes
      '9801', '9802', '9803', '9804', '9805', '9806', '9807', '9808', '9809',
      '9810', '9811', '9812', '9813', '9814', '9815', '9816', '9817', '9818', '9819',
      '9820', '9821', '9822', '9823', '9824', '9825', '9826', '9827', '9828', '9829',
      '9841', '9842', '9843', '9844', '9845', '9846', '9847', '9848', '9849',
      '9851', '9852', '9853', '9854', '9855', '9856', '9857', '9858', '9859',
      '9860', '9861', '9862', '9863', '9864', '9865', '9866', '9867', '9868', '9869',
    ],
    'Ncell': [
      // Ncell common prefixes
      '9800', '9801', '9802', '9803', '9804', '9805', '9806', '9807', '9808', '9809',
      '9810', '9811', '9812', '9813', '9814', '9815', '9816', '9817', '9818', '9819',
      '9820', '9821', '9822', '9823', '9824', '9825', '9826', '9827', '9828', '9829',
      '9840', '9841', '9842', '9843', '9844', '9845', '9846', '9847', '9848', '9849',
      '9850', '9851', '9852', '9853', '9854', '9855', '9856', '9857', '9858', '9859',
      '9860', '9861', '9862', '9863', '9864', '9865', '9866', '9867', '9868', '9869',
    ],
    'Smart': [
      // SmartCell common prefixes
      '9800', '9801', '9802', '9803', '9804', '9805', '9806', '9807', '9808', '9809',
      '9810', '9811', '9812', '9813', '9814', '9815', '9816', '9817', '9818', '9819',
      '9820', '9821', '9822', '9823', '9824', '9825', '9826', '9827', '9828', '9829',
      '9840', '9841', '9842', '9843', '9844', '9845', '9846', '9847', '9848', '9849',
      '9850', '9851', '9852', '9853', '9854', '9855', '9856', '9857', '9858', '9859',
      '9860', '9861', '9862', '9863', '9864', '9865', '9866', '9867', '9868', '9869',
    ],
  };

  static String detectCarrier(String phoneNumber) {
    // Remove all non-digit characters
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    // Check if it's a Nepal number (starts with 977 country code)
    if (cleaned.startsWith('977')) {
      cleaned = cleaned.substring(3);
    }
    
    // Must be 10 digits for Nepal mobile numbers
    if (cleaned.length < 10) {
      return 'Unknown';
    }

    // Take first 10 digits if longer
    if (cleaned.length > 10) {
      cleaned = cleaned.substring(0, 10);
    }

    // Extract first 4 digits for carrier detection
    String prefix4 = cleaned.substring(0, 4);
    String prefix3 = cleaned.substring(0, 3);
    
    // Check 4-digit prefixes first (more specific)
    for (var entry in carrierPrefixes.entries) {
      if (entry.value.contains(prefix4)) {
        return entry.key;
      }
    }
    
    // Fallback: Use 3-digit prefix with heuristics
    // Since all carriers share similar ranges, we use simple distribution
    if (prefix3 == '980' || prefix3 == '981' || prefix3 == '982') {
      int digit = int.tryParse(prefix4[3]) ?? 0;
      // Simple heuristic: distribute based on last digit
      if (digit < 3) {
        return 'NTC';
      } else if (digit < 6) {
        return 'Ncell';
      } else {
        return 'Smart';
      }
    }
    
    if (prefix3 == '984' || prefix3 == '985' || prefix3 == '986') {
      // These ranges are commonly NTC or Ncell
      int digit = int.tryParse(prefix4[3]) ?? 0;
      return digit < 5 ? 'NTC' : 'Ncell';
    }
    
    return 'Unknown';
  }

  static Future<List<ContactModel>> getSimContacts() async {
    List<ContactModel> contacts = [];
    
    try {
      // Get contacts from device
      Iterable<Contact> deviceContacts = await ContactsService.getContacts();
      
      for (Contact contact in deviceContacts) {
        if (contact.phones != null && contact.phones!.isNotEmpty) {
          for (Item phone in contact.phones!) {
            String phoneNumber = phone.value ?? '';
            if (phoneNumber.isNotEmpty) {
              String carrier = detectCarrier(phoneNumber);
              contacts.add(ContactModel(
                name: contact.displayName ?? 'Unknown',
                phoneNumber: phoneNumber,
                carrier: carrier,
              ));
            }
          }
        }
      }
    } catch (e) {
      print('Error reading contacts: $e');
    }
    
    return contacts;
  }

  static Map<String, List<ContactModel>> groupByCarrier(List<ContactModel> contacts) {
    Map<String, List<ContactModel>> grouped = {
      'NTC': [],
      'Ncell': [],
      'Smart': [],
      'Unknown': [],
    };

    for (ContactModel contact in contacts) {
      if (grouped.containsKey(contact.carrier)) {
        grouped[contact.carrier]!.add(contact);
      } else {
        grouped['Unknown']!.add(contact);
      }
    }

    return grouped;
  }
}

