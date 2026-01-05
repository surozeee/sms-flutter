import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import '../models/contact_model.dart';
import 'contact_service.dart';

class ExcelService {
  /// Pick Excel file
  static Future<File?> pickExcelFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      throw Exception('Error picking Excel file: $e');
    }
  }

  /// Read contacts from Excel
  static Future<List<ContactModel>> readContactsFromExcel(File file) async {
    List<ContactModel> contacts = [];
    
    try {
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      
      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet == null) continue;
        
        // Skip header row (assuming first row is header)
        var rows = sheet.rows;
        for (var i = 1; i < rows.length; i++) {
          var row = rows[i];
          if (row.isEmpty) continue;
          
          String name = '';
          String phone = '';
          
          // Try to extract name and phone from columns
          if (row.length > 0 && row[0] != null) {
            name = row[0]!.value?.toString() ?? '';
          }
          if (row.length > 1 && row[1] != null) {
            phone = row[1]!.value?.toString() ?? '';
          }
          
          // Clean phone number
          phone = phone.replaceAll(RegExp(r'[^\d]'), '');
          
          if (name.isNotEmpty && phone.isNotEmpty && phone.length >= 10) {
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
      throw Exception('Error reading Excel file: $e');
    }
    
    return contacts;
  }

  /// Export contacts to Excel
  static Future<File?> exportContactsToExcel(List<ContactModel> contacts) async {
    try {
      var excel = Excel.createExcel();
      excel.delete('Sheet1');
      Sheet? sheetObject = excel['Contacts'];
      
      // Add headers
      sheetObject.appendRow([
        TextCellValue('Name'),
        TextCellValue('Phone Number'),
        TextCellValue('Carrier'),
      ]);
      
      // Add data
      for (var contact in contacts) {
        sheetObject.appendRow([
          TextCellValue(contact.name),
          TextCellValue(contact.phoneNumber),
          TextCellValue(contact.carrier),
        ]);
      }
      
      // Save file
      String fileName = 'contacts_${DateTime.now().millisecondsSinceEpoch}.xlsx';
      List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File file = File(fileName);
        await file.writeAsBytes(fileBytes);
        return file;
      }
      
      return null;
    } catch (e) {
      throw Exception('Error exporting Excel file: $e');
    }
  }
}

