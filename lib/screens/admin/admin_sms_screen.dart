import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/api/api_endpoints.dart';
import '../../core/providers/auth_provider.dart';
import '../../models/contact_model.dart';
import '../../services/contact_service.dart';
import '../../services/csv_service.dart';
import '../../services/excel_service.dart';

enum ContactSource { sim, csv, excel }

class AdminSmsScreen extends ConsumerStatefulWidget {
  const AdminSmsScreen({super.key});

  @override
  ConsumerState<AdminSmsScreen> createState() => _AdminSmsScreenState();
}

class _AdminSmsScreenState extends ConsumerState<AdminSmsScreen> {
  ContactSource? _selectedSource;
  List<ContactModel> _contacts = [];
  Map<String, List<ContactModel>> _groupedContacts = {};
  String? _selectedCarrierFilter;
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isSending = false;
  bool _isSendingViaServer = false;
  String _statusMessage = '';
  int _sentCount = 0;
  int _failedCount = 0;
  String? _loadedFileName;

  final List<String> _carriers = ['NTC', 'Ncell', 'Smart Cell', 'Unknown'];
  final Map<String, Color> _carrierColors = {
    'NTC': Colors.blue,
    'Ncell': Colors.green,
    'Smart Cell': Colors.orange,
    'Unknown': Colors.grey,
  };

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Scroll to text field when keyboard opens
    _messageFocusNode.addListener(() {
      if (_messageFocusNode.hasFocus) {
        // Delay to ensure keyboard is fully open
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  Future<void> _loadSimContacts() async {
    setState(() {
      _isLoading = true;
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
            const SnackBar(
              content: Text('Contacts permission is required'),
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

      if (contacts.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'No contacts found. Please ensure you have contacts with phone numbers in your device.'),
              duration: Duration(seconds: 4),
            ),
          );
        }
        return;
      }

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
            content: Text('Loaded ${contacts.length} contacts'),
            duration: const Duration(seconds: 2),
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
            content: Text('Error loading contacts: $e'),
            duration: const Duration(seconds: 4),
          ),
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

    // Prepare mobile numbers list (outside try block for error handling)
    final mobileNumbers =
        selected.map((contact) => contact.phoneNumber).toList();

    setState(() {
      _isSending = true;
      _statusMessage = 'Sending SMS...';
      _sentCount = 0;
      _failedCount = 0;
    });

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      // Call bulk SMS API
      final response = await dioClient.postJson(
        ApiEndpoints.mobileBulkSendSms,
        data: {
          'mobileNumbers': mobileNumbers,
          'message': _messageController.text.trim(),
          'smsType': 'MOBILE',
        },
        requiresAuth: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final status = responseData is Map<String, dynamic>
            ? responseData['status'] as String?
            : null;

        if (status == 'SUCCESS') {
          final sentCount = responseData is Map<String, dynamic>
              ? (responseData['data']?['sentCount'] ?? mobileNumbers.length)
                  as int?
              : mobileNumbers.length;

          setState(() {
            _isSending = false;
            _sentCount = sentCount ?? mobileNumbers.length;
            _failedCount =
                mobileNumbers.length - (sentCount ?? mobileNumbers.length);
            _statusMessage = responseData is Map<String, dynamic>
                ? (responseData['message'] ?? 'SMS sent successfully') as String
                : 'SMS sent successfully';
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
        } else {
          // Handle error response
          final errorMessage = responseData is Map<String, dynamic>
              ? (responseData['message'] ?? 'Failed to send SMS') as String
              : 'Failed to send SMS';

          setState(() {
            _isSending = false;
            _statusMessage = errorMessage;
            _failedCount = mobileNumbers.length;
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        throw Exception(
            'Failed to send SMS with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Extract error message from API response
      String errorMessage = 'Failed to send SMS';

      // Try to get message from DioException (which comes from interceptor)
      if (e.message != null && e.message!.isNotEmpty) {
        errorMessage = e.message!;
      } else if (e.response?.data != null) {
        // Extract from response data
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic>) {
          errorMessage = responseData['message'] as String? ??
              responseData['error'] as String? ??
              responseData['errorMessage'] as String? ??
              responseData['msg'] as String? ??
              errorMessage;

          // If message is a list, join it
          if (responseData['message'] is List) {
            final messages = responseData['message'] as List;
            if (messages.isNotEmpty) {
              errorMessage = messages.map((e) => e.toString()).join(', ');
            }
          }
        } else if (responseData is String) {
          errorMessage = responseData;
        }
      }

      setState(() {
        _isSending = false;
        _statusMessage = errorMessage;
        _failedCount = mobileNumbers.length;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      // Handle non-DioException errors
      final errorMessage = e.toString().replaceFirst('Exception: ', '');

      setState(() {
        _isSending = false;
        _statusMessage = errorMessage;
        _failedCount = mobileNumbers.length;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _sendSmsViaServer() async {
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
        title: const Text('Confirm Send SMS via Server'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send SMS to ${selected.length} contact(s) via server?',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Please ensure you have sufficient balance to send via server before proceeding.',
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This action cannot be undone.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Send via Server'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // Prepare mobile numbers list (outside try block for error handling)
    final mobileNumbers =
        selected.map((contact) => contact.phoneNumber).toList();

    setState(() {
      _isSendingViaServer = true;
      _statusMessage = 'Sending SMS via server...';
      _sentCount = 0;
      _failedCount = 0;
    });

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      // Call bulk SMS API
      final response = await dioClient.postJson(
        ApiEndpoints.mobileBulkSendSms,
        data: {
          'mobileNumbers': mobileNumbers,
          'message': _messageController.text.trim(),
          'smsType': 'API',
        },
        requiresAuth: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final status = responseData is Map<String, dynamic>
            ? responseData['status'] as String?
            : null;

        if (status == 'SUCCESS') {
          final sentCount = responseData is Map<String, dynamic>
              ? (responseData['data']?['sentCount'] ?? mobileNumbers.length)
                  as int?
              : mobileNumbers.length;

          setState(() {
            _isSendingViaServer = false;
            _sentCount = sentCount ?? mobileNumbers.length;
            _failedCount =
                mobileNumbers.length - (sentCount ?? mobileNumbers.length);
            _statusMessage = responseData is Map<String, dynamic>
                ? (responseData['message'] ??
                    'SMS sent successfully via server') as String
                : 'SMS sent successfully via server';
          });

          if (mounted) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('SMS Status (via Server)'),
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
        } else {
          // Handle error response
          final errorMessage = responseData is Map<String, dynamic>
              ? (responseData['message'] ?? 'Failed to send SMS via server')
                  as String
              : 'Failed to send SMS via server';

          setState(() {
            _isSendingViaServer = false;
            _statusMessage = errorMessage;
            _failedCount = mobileNumbers.length;
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        throw Exception(
            'Failed to send SMS via server with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Extract error message from API response
      String errorMessage = 'Failed to send SMS via server';

      // Try to get message from DioException (which comes from interceptor)
      if (e.message != null && e.message!.isNotEmpty) {
        errorMessage = e.message!;
      } else if (e.response?.data != null) {
        // Extract from response data
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic>) {
          errorMessage = responseData['message'] as String? ??
              responseData['error'] as String? ??
              responseData['errorMessage'] as String? ??
              responseData['msg'] as String? ??
              errorMessage;

          // If message is a list, join it
          if (responseData['message'] is List) {
            final messages = responseData['message'] as List;
            if (messages.isNotEmpty) {
              errorMessage = messages.map((e) => e.toString()).join(', ');
            }
          }
        } else if (responseData is String) {
          errorMessage = responseData;
        }
      }

      setState(() {
        _isSendingViaServer = false;
        _statusMessage = errorMessage;
        _failedCount = mobileNumbers.length;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      // Handle non-DioException errors
      final errorMessage = e.toString().replaceFirst('Exception: ', '');

      setState(() {
        _isSendingViaServer = false;
        _statusMessage = errorMessage;
        _failedCount = mobileNumbers.length;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                const SizedBox(height: 12),
                DropdownButtonFormField<ContactSource>(
                  value: _selectedSource,
                  decoration: InputDecoration(
                    hintText: 'Select contact source',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    prefixIcon: const Icon(Icons.source),
                  ),
                  items: [
                    DropdownMenuItem<ContactSource>(
                      value: ContactSource.sim,
                      child: Row(
                        children: [
                          Icon(Icons.sim_card, color: Colors.blue, size: 20),
                          const SizedBox(width: 12),
                          const Text('SIM Contacts'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<ContactSource>(
                      value: ContactSource.csv,
                      child: Row(
                        children: [
                          Icon(Icons.description,
                              color: Colors.green, size: 20),
                          const SizedBox(width: 12),
                          const Text('CSV File'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<ContactSource>(
                      value: ContactSource.excel,
                      child: Row(
                        children: [
                          Icon(Icons.table_chart,
                              color: Colors.orange, size: 20),
                          const SizedBox(width: 12),
                          const Text('Excel File'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (ContactSource? value) {
                    if (value != null) {
                      setState(() {
                        _selectedSource = value;
                        _loadedFileName = null;
                      });
                      // Trigger import based on selected source
                      if (value == ContactSource.sim) {
                        _loadSimContacts();
                      } else if (value == ContactSource.csv) {
                        _loadCsvFile();
                      } else if (value == ContactSource.excel) {
                        _loadExcelFile();
                      }
                    }
                  },
                ),
                if (_loadedFileName != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            size: 20, color: Colors.green.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Loaded: $_loadedFileName',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Carrier Filter
          if (_contacts.isNotEmpty)
            Container(
              padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
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
                    spacing: 16,
                    children: [
                      _buildCarrierChip('All', null),
                      ..._carriers.map(
                          (carrier) => _buildCarrierChip(carrier, carrier)),
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

          // Continue Button
          if (_totalSelected > 0)
            Container(
              width: double.infinity,
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
              child: ElevatedButton.icon(
                onPressed: _showSmsBottomSheet,
                icon: const Icon(Icons.message),
                label: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
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
                                '${contacts.length} contacts ($selectedCount selected)',
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
                                            _carrierColors[carrier]!
                                                .withOpacity(0.2),
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
        ],
      ),
    );
  }

  int get _smsCount {
    final length = _messageController.text.length;
    if (length == 0) return 0;
    if (length <= 160) return 1;
    return ((length - 160) / 153).ceil() + 1;
  }

  void _showSmsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.55,
        maxChildSize: 0.8,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    const Text(
                      'Compose SMS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Selected contacts info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.people,
                                color: Colors.blue.shade700, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$_totalSelected Contact${_totalSelected == 1 ? '' : 's'} Selected',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Ready to send SMS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Message input
                      const Text(
                        'SMS Message',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _messageController,
                        focusNode: _messageFocusNode,
                        maxLines: 6,
                        minLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Type your message here...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.all(16),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 10),
                      // Clear message button
                      if (_messageController.text.isNotEmpty)
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            tooltip: 'Clear message',
                            onPressed: () {
                              setState(() {
                                _messageController.clear();
                              });
                            },
                          ),
                        ),
                      const SizedBox(height: 20),
                      // Send buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: (_isSending ||
                                      _isSendingViaServer ||
                                      _totalSelected == 0)
                                  ? null
                                  : () {
                                      Navigator.pop(context);
                                      _sendSms();
                                    },
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
                              label:
                                  Text(_isSending ? 'Sending...' : 'Send SMS'),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: (_isSending ||
                                      _isSendingViaServer ||
                                      _totalSelected == 0)
                                  ? null
                                  : () {
                                      Navigator.pop(context);
                                      _sendSmsViaServer();
                                    },
                              icon: _isSendingViaServer
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.cloud_upload),
                              label: Text(_isSendingViaServer
                                  ? 'Sending...'
                                  : 'Via Server'),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      backgroundColor:
          carrier != null ? _carrierColors[carrier]!.withOpacity(0.1) : null,
      selectedColor:
          carrier != null ? _carrierColors[carrier]!.withOpacity(0.3) : null,
      checkmarkColor: carrier != null ? _carrierColors[carrier] : null,
    );
  }
}
