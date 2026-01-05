import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../services/contact_service.dart';
import '../../services/excel_service.dart';
import '../../models/contact_model.dart';

class MemberContactsScreen extends StatefulWidget {
  const MemberContactsScreen({super.key});

  @override
  State<MemberContactsScreen> createState() => _MemberContactsScreenState();
}

class _MemberContactsScreenState extends State<MemberContactsScreen> {
  List<ContactModel> _contacts = [];
  Map<String, List<ContactModel>> _groupedContacts = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final contacts = await ContactService.getSimContacts();
      final grouped = ContactService.groupByCarrier(contacts);
      setState(() {
        _contacts = contacts;
        _groupedContacts = grouped;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadExcel() async {
    try {
      final file = await ExcelService.pickExcelFile();
      if (file == null) return;

      final excelContacts = await ExcelService.readContactsFromExcel(file);
      setState(() {
        _contacts.addAll(excelContacts);
        _groupedContacts = ContactService.groupByCarrier(_contacts);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${excelContacts.length} contacts added from Excel'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: _uploadExcel,
            tooltip: 'Upload Excel',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contact Summary',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSummaryRow('Total Contacts', _contacts.length.toString()),
                          _buildSummaryRow('NTC', _groupedContacts['NTC']?.length.toString() ?? '0'),
                          _buildSummaryRow('Ncell', _groupedContacts['Ncell']?.length.toString() ?? '0'),
                          _buildSummaryRow('Smart', _groupedContacts['Smart']?.length.toString() ?? '0'),
                          _buildSummaryRow('Other', _groupedContacts['Unknown']?.length.toString() ?? '0'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

