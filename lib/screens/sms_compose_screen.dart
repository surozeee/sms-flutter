import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../services/sms_service.dart';

class SmsComposeScreen extends StatefulWidget {
  final List<ContactModel> selectedContacts;

  const SmsComposeScreen({
    super.key,
    required this.selectedContacts,
  });

  @override
  State<SmsComposeScreen> createState() => _SmsComposeScreenState();
}

class _SmsComposeScreenState extends State<SmsComposeScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;
  String _statusMessage = '';
  int _sentCount = 0;
  int _failedCount = 0;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendSms() async {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a message'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSending = true;
      _statusMessage = 'Sending SMS...';
      _sentCount = 0;
      _failedCount = 0;
    });

    try {
      final result = await SmsService.sendBulkSms(
        contacts: widget.selectedContacts,
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
                Text('Total Selected: ${widget.selectedContacts.length}'),
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
                    Navigator.of(context).pop();
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
    final selectedCount = widget.selectedContacts.length;
    final groupedByCarrier = <String, List<ContactModel>>{};
    
    for (var contact in widget.selectedContacts) {
      if (!groupedByCarrier.containsKey(contact.carrier)) {
        groupedByCarrier[contact.carrier] = [];
      }
      groupedByCarrier[contact.carrier]!.add(contact);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose SMS'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Selected contacts summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected: $selectedCount contact(s)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: groupedByCarrier.entries.map((entry) {
                    return Chip(
                      label: Text('${entry.key}: ${entry.value.length}'),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Message input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _messageController,
                  maxLines: 8,
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
                Text(
                  '${_messageController.text.length} characters',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Status message
          if (_statusMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _isSending
                      ? Colors.blue.shade50
                      : _sentCount > 0
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (_isSending)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      Icon(
                        _sentCount > 0 ? Icons.check_circle : Icons.error,
                        color: _sentCount > 0 ? Colors.green : Colors.red,
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _statusMessage,
                        style: TextStyle(
                          color: _sentCount > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const Spacer(),

          // Send button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
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
                label: Text(_isSending ? 'Sending...' : 'Send SMS'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

