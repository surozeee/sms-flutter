import 'package:flutter_contacts/flutter_contacts.dart';
import '../models/contact_model.dart';

class ContactService {
  // Carrier prefixes for Nepal
  // NTC: 984, 985, 986, 976, 974, 975
  // Ncell: 980, 981, 982, 970, 971
  // Smart Cell: 961, 962, 988
  static const Map<String, List<String>> carrierPrefixes = {
    'NTC': [
      // NTC (Nepal Telecom) - 984, 985, 986, 976, 974, 975
      '9840', '9841', '9842', '9843', '9844', '9845', '9846', '9847', '9848', '9849',
      '9850', '9851', '9852', '9853', '9854', '9855', '9856', '9857', '9858', '9859',
      '9860', '9861', '9862', '9863', '9864', '9865', '9866', '9867', '9868', '9869',
      '9760', '9761', '9762', '9763', '9764', '9765', '9766', '9767', '9768', '9769',
      '9740', '9741', '9742', '9743', '9744', '9745', '9746', '9747', '9748', '9749',
      '9750', '9751', '9752', '9753', '9754', '9755', '9756', '9757', '9758', '9759',
    ],
    'Ncell': [
      // Ncell - 980, 981, 982, 970, 971
      '9800', '9801', '9802', '9803', '9804', '9805', '9806', '9807', '9808', '9809',
      '9810', '9811', '9812', '9813', '9814', '9815', '9816', '9817', '9818', '9819',
      '9820', '9821', '9822', '9823', '9824', '9825', '9826', '9827', '9828', '9829',
      '9700', '9701', '9702', '9703', '9704', '9705', '9706', '9707', '9708', '9709',
      '9710', '9711', '9712', '9713', '9714', '9715', '9716', '9717', '9718', '9719',
    ],
    'Smart Cell': [
      // Smart Cell - 961, 962, 988
      '9610', '9611', '9612', '9613', '9614', '9615', '9616', '9617', '9618', '9619',
      '9620', '9621', '9622', '9623', '9624', '9625', '9626', '9627', '9628', '9629',
      '9880', '9881', '9882', '9883', '9884', '9885', '9886', '9887', '9888', '9889',
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

    // Extract first 3 digits for carrier detection
    String prefix3 = cleaned.substring(0, 3);
    
    // Check 3-digit prefixes for carrier detection
    if (prefix3 == '984' || prefix3 == '985' || prefix3 == '986' || 
        prefix3 == '976' || prefix3 == '974' || prefix3 == '975') {
      return 'NTC';
    }
    
    if (prefix3 == '980' || prefix3 == '981' || prefix3 == '982' || 
        prefix3 == '970' || prefix3 == '971') {
      return 'Ncell';
    }
    
    if (prefix3 == '961' || prefix3 == '962' || prefix3 == '988') {
      return 'Smart Cell';
    }
    
    return 'Unknown';
  }

  static Future<List<ContactModel>> getSimContacts() async {
    List<ContactModel> contacts = [];
    
    try {
      // Request permission first
      final permission = await FlutterContacts.requestPermission();
      if (!permission) {
        throw Exception('Contacts permission denied');
      }
      
      // Get contacts from device
      List<Contact> deviceContacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
      
      for (Contact contact in deviceContacts) {
        if (contact.phones.isNotEmpty) {
          for (Phone phone in contact.phones) {
            String phoneNumber = phone.number;
            if (phoneNumber.isNotEmpty) {
              String carrier = detectCarrier(phoneNumber);
              String contactName = contact.displayName;
              if (contactName.isEmpty) {
                List<String> nameParts = [
                  contact.name.first,
                  contact.name.last,
                ].where((part) => part.isNotEmpty).toList();
                contactName = nameParts.isNotEmpty 
                    ? nameParts.join(' ').trim()
                    : 'Unknown';
              }
              
              contacts.add(ContactModel(
                name: contactName,
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
      'Smart Cell': [],
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

