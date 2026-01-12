import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../models/contact_model.dart';
import 'contact_service.dart';

class CsvService {
  /// Pick CSV file
  static Future<File?> pickCsvFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      throw Exception('Error picking CSV file: $e');
    }
  }

  /// Read contacts from CSV file
  static Future<List<ContactModel>> readContactsFromCsv(File file) async {
    List<ContactModel> contacts = [];
    
    try {
      final lines = await file.readAsLines();
      
      if (lines.isEmpty) {
        return contacts;
      }
      
      // Skip header row (first line)
      for (int i = 1; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;
        
        // Parse CSV line (handle quoted values)
        final values = _parseCsvLine(line);
        
        if (values.length >= 2) {
          String name = values[0].trim();
          String phone = values[1].trim();
          
          // Normalize phone number using the same logic as ContactService
          phone = _normalizePhoneNumber(phone);
          
          // Validate phone number (should be at least 7 digits for Nepal)
          if (name.isNotEmpty && phone.isNotEmpty && phone.length >= 7) {
            String carrier = ContactService.detectCarrier(phone);
            
            // Filter: Only include NTC and Ncell carriers
            if (carrier == 'NTC' || carrier == 'Ncell') {
              contacts.add(ContactModel(
                name: name,
                phoneNumber: phone,
                carrier: carrier,
              ));
            }
          }
        }
      }
    } catch (e) {
      throw Exception('Error reading CSV file: $e');
    }
    
    return contacts;
  }

  /// Parse CSV line handling quoted values
  static List<String> _parseCsvLine(String line) {
    List<String> values = [];
    String current = '';
    bool inQuotes = false;
    
    for (int i = 0; i < line.length; i++) {
      final char = line[i];
      
      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        values.add(current);
        current = '';
      } else {
        current += char;
      }
    }
    
    // Add last value
    values.add(current);
    
    return values;
  }

  /// Normalize phone number to standard format (same logic as ContactService)
  static String _normalizePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return '';
    
    // Remove all non-digit characters except +
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    // If number starts with +, take the last 10 digits
    if (cleaned.startsWith('+')) {
      // Remove the + sign
      cleaned = cleaned.substring(1);
      // Take last 10 digits
      if (cleaned.length >= 10) {
        cleaned = cleaned.substring(cleaned.length - 10);
      }
    } else {
      // Handle country code 977 (without +)
      if (cleaned.startsWith('977')) {
        cleaned = cleaned.substring(3);
      }
      
      // Remove leading zeros
      cleaned = cleaned.replaceFirst(RegExp(r'^0+'), '');
      
      // Take last 10 digits if longer
      if (cleaned.length > 10) {
        cleaned = cleaned.substring(cleaned.length - 10);
      }
    }
    
    // Return cleaned number
    return cleaned.trim();
  }

  /// Export contacts to CSV
  static Future<File?> exportContactsToCsv(List<ContactModel> contacts) async {
    try {
      final buffer = StringBuffer();
      
      // Add header
      buffer.writeln('Name,Phone Number,Carrier');
      
      // Add data
      for (var contact in contacts) {
        buffer.writeln('"${contact.name}","${contact.phoneNumber}","${contact.carrier}"');
      }
      
      // Save file
      String fileName = 'contacts_${DateTime.now().millisecondsSinceEpoch}.csv';
      File file = File(fileName);
      await file.writeAsString(buffer.toString());
      
      return file;
    } catch (e) {
      throw Exception('Error exporting CSV file: $e');
    }
  }
}

