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
          
          // Clean phone number - remove all non-digit characters
          phone = phone.replaceAll(RegExp(r'[^\d]'), '');
          
          // Remove country code if present (977)
          if (phone.startsWith('977')) {
            phone = phone.substring(3);
          }
          
          // Validate phone number (should be 10 digits for Nepal)
          if (name.isNotEmpty && phone.isNotEmpty && phone.length >= 10) {
            // Take first 10 digits if longer
            if (phone.length > 10) {
              phone = phone.substring(0, 10);
            }
            
            String carrier = ContactService.detectCarrier(phone);
            contacts.add(ContactModel(
              name: name,
              phoneNumber: phone,
              carrier: carrier,
            ));
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

