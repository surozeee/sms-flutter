import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../../models/contact_model.dart';
import '../../services/contact_service.dart';
import '../../services/sms_service.dart';
import '../../services/excel_service.dart';
import '../../services/csv_service.dart';

enum ContactSource { sim, csv, excel }

class AdminSmsScreen extends StatefulWidget {
  const AdminSmsScreen({super.key});

  @override
  State<AdminSmsScreen> createState() => _AdminSmsScreenState();
}

class _AdminSmsScreenState extends State<AdminSmsScreen> {
  ContactSource _selectedSource = ContactSource.sim;
  List<ContactModel> _contacts = [];
  Map<String, List<ContactModel>> _groupedContacts = {};
  String? _selectedCarrierFilter;
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;
  bool _isSending = false;
  String _statusMessage = '';
  int _sentCount = 0;
  int _failedCount = 0;
  String? _loadedFileName;

  final List<String> _carriers = ['NTC', 'Ncell', 'Smart', 'Unknown'];
  final Map<String, Color> _carrierColors = {
    'NTC': Colors.blue,
    'Ncell': Colors.green,
    'Smart': Colors.orange,
    'Unknown': Colors.grey,
  };

  @override
  void initState() {
    super.initState();
    _loadSimContacts();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadSimContacts() async {
    setState(() {
      _isLoading = true;
      _selectedSource = ContactSource.sim;
      _loadedFileName = null;
    });

    // Check permissions
    final contactsPermission = await Permission.contacts.status;
    if (!contactsPermission.isGranted) {
      final status = await Permission.contacts.request();
      if (!status.isGranted) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Contacts permission is required'),
              action: SnackBarAction(
                label: 'Open Settings',
                onPressed: openAppSettings,
              ),
            ),
          );
        }
        return;
      }
    }

    try {
      final contacts = await ContactService.getSimContacts();
      
      // Select all by default
      for (var contact in contacts) {
        contact.isSelected = true;
      }

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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading contacts: $e')),
        );
      }
    }
  }

  Future<void> _loadCsvFile() async {
    try {
      final file = await CsvService.pickCsvFile();
      if (file == null) return;

      setState(() {
        _isLoading = true;
        _selectedSource = ContactSource.csv;
        _loadedFileName = file.path.split('/').last;
      });

      final contacts = await CsvService.readContactsFromCsv(file);
      
      // Select all by default
      for (var contact in contacts) {
        contact.isSelected = true;
      }

      final grouped = ContactService.groupByCarrier(contacts);
      
      setState(() {
        _contacts = contacts;
        _groupedContacts = grouped;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loaded ${contacts.length} contacts from CSV'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading CSV: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loadExcelFile() async {
    try {
      final file = await ExcelService.pickExcelFile();
      if (file == null) return;

      setState(() {
        _isLoading = true;
        _selectedSource = ContactSource.excel;
        _loadedFileName = file.path.split('/').last;
      });

      final contacts = await ExcelService.readContactsFromExcel(file);
      
      // Select all by default
      for (var contact in contacts) {
        contact.isSelected = true;
      }

      final grouped = ContactService.groupByCarrier(contacts);
      
      setState(() {
        _contacts = contacts;
        _groupedContacts = grouped;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loaded ${contacts.length} contacts from Excel'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading Excel: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _filterByCarrier(String? carrier) {
    setState(() {
      _selectedCarrierFilter = carrier;
    });
  }

  Map<String, List<ContactModel>> get _filteredContacts {
    if (_selectedCarrierFilter == null || _selectedCarrierFilter!.isEmpty) {
      return _groupedContacts;
    }
    return {
      _selectedCarrierFilter!: _groupedContacts[_selectedCarrierFilter!] ?? [],
    };
  }

  int get _totalSelected {
    int count = 0;
    for (var contacts in _groupedContacts.values) {
      count += contacts.where((c) => c.isSelected).length;
    }
    return count;
  }

  List<ContactModel> get _selectedContacts {
    List<ContactModel> selected = [];
    for (var contacts in _groupedContacts.values) {
      selected.addAll(contacts.where((c) => c.isSelected));
    }
    return selected;
  }

  void _toggleContactSelection(String carrier, int index) {
    setState(() {
      _groupedContacts[carrier]![index].isSelected =
          !_groupedContacts[carrier]![index].isSelected;
    });
  }

  void _toggleCarrierSelection(String carrier, bool select) {
    setState(() {
      for (var contact in _groupedContacts[carrier]!) {
        contact.isSelected = select;
      }
    });
  }

  String _formatPhoneNumber(String phoneNumber) {
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    if (cleaned.startsWith('977')) {
      cleaned = cleaned.substring(3);
    }
    
    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7)}';
    }
    
    return phoneNumber;
  }

  Future<void> _sendSms() async {
    final selected = _selectedContacts;
    
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one contact'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a message'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Confirm before sending
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Send SMS'),
        content: Text(
          'Send SMS to ${selected.length} contact(s)?\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Send'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      _isSending = true;
      _statusMessage = 'Sending SMS...';
      _sentCount = 0;
      _failedCount = 0;
    });

    try {
      final result = await SmsService.sendBulkSms(
        contacts: selected,
        message: _messageController.text.trim(),
      );

      setState(() {
        _isSending = false;
        _sentCount = result['sentCount'] ?? 0;
        _failedCount = result['failedCount'] ?? 0;
        _statusMessage = result['message'] ?? 'Completed';
      });

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('SMS Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Selected: ${selected.length}'),
                const SizedBox(height: 8),
                Text(
                  'Sent: $_sentCount',
                  style: const TextStyle(color: Colors.green),
                ),
                if (_failedCount > 0)
                  Text(
                    'Failed: $_failedCount',
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 8),
                Text(_statusMessage),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (_sentCount > 0) {
                    _messageController.clear();
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSending = false;
        _statusMessage = 'Error: $e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending SMS: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin SMS'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload Contacts',
            onPressed: _loadSimContacts,
          ),
        ],
      ),
      body: Column(
        children: [
          // Source Selection
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Contact Source',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildSourceButton(
                        'SIM Contacts',
                        Icons.sim_card,
                        ContactSource.sim,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildSourceButton(
                        'CSV File',
                        Icons.description,
                        ContactSource.csv,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildSourceButton(
                        'Excel File',
                        Icons.table_chart,
                        ContactSource.excel,
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
                if (_loadedFileName != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Loaded: $_loadedFileName',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Carrier Filter
          if (_contacts.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter by Carrier',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildCarrierChip('All', null),
                      ..._carriers.map((carrier) => _buildCarrierChip(carrier, carrier)),
                    ],
                  ),
                ],
              ),
            ),

          // Selected Count
          if (_totalSelected > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                '$_totalSelected contact(s) selected',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Contacts List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _contacts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.contacts_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No contacts loaded',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Select a source to load contacts',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _carriers.length,
                        itemBuilder: (context, index) {
                          final carrier = _carriers[index];
                          final contacts = _filteredContacts[carrier] ?? [];
                          final selectedCount =
                              contacts.where((c) => c.isSelected).length;
                          final allSelected = contacts.isNotEmpty &&
                              selectedCount == contacts.length;

                          if (contacts.isEmpty) return const SizedBox.shrink();

                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              leading: CircleAvatar(
                                backgroundColor: _carrierColors[carrier],
                                child: Text(
                                  carrier[0],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                carrier,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                '${contacts.length} contacts (${selectedCount} selected)',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: allSelected,
                                    tristate: true,
                                    onChanged: (value) {
                                      _toggleCarrierSelection(
                                        carrier,
                                        value ?? false,
                                      );
                                    },
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: contacts.length,
                                  itemBuilder: (context, contactIndex) {
                                    final contact = contacts[contactIndex];
                                    return ListTile(
                                      leading: Checkbox(
                                        value: contact.isSelected,
                                        onChanged: (value) {
                                          _toggleContactSelection(
                                            carrier,
                                            contactIndex,
                                          );
                                        },
                                      ),
                                      title: Text(contact.name),
                                      subtitle: Text(
                                        _formatPhoneNumber(contact.phoneNumber),
                                        style: const TextStyle(
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      trailing: Chip(
                                        label: Text(contact.carrier),
                                        backgroundColor:
                                            _carrierColors[carrier]!.withOpacity(0.2),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),

          // SMS Compose Section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SMS Message',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Type your message here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_messageController.text.length} characters',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    if (_statusMessage.isNotEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            _statusMessage,
                            style: TextStyle(
                              color: _sentCount > 0 ? Colors.green : Colors.red,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSending ? null : _sendSms,
                    icon: _isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                    label: Text(_isSending
                        ? 'Sending...'
                        : 'Send SMS to $_totalSelected'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceButton(
    String label,
    IconData icon,
    ContactSource source,
    Color color,
  ) {
    final isSelected = _selectedSource == source;
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {
          _selectedSource = source;
        });
        if (source == ContactSource.sim) {
          _loadSimContacts();
        } else if (source == ContactSource.csv) {
          _loadCsvFile();
        } else if (source == ContactSource.excel) {
          _loadExcelFile();
        }
      },
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? color.withOpacity(0.1) : null,
        side: BorderSide(
          color: isSelected ? color : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
      ),
    );
  }

  Widget _buildCarrierChip(String label, String? carrier) {
    final isSelected = _selectedCarrierFilter == carrier;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        _filterByCarrier(selected ? carrier : null);
      },
      backgroundColor: carrier != null
          ? _carrierColors[carrier]!.withOpacity(0.1)
          : null,
      selectedColor: carrier != null
          ? _carrierColors[carrier]!.withOpacity(0.3)
          : null,
      checkmarkColor: carrier != null ? _carrierColors[carrier] : null,
    );
  }
}

