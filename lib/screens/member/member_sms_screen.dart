import 'package:flutter/material.dart';
import '../../services/contact_service.dart';
import '../../services/sms_gateway_service.dart';
import '../contacts_screen.dart';

class MemberSmsScreen extends StatefulWidget {
  const MemberSmsScreen({super.key});

  @override
  State<MemberSmsScreen> createState() => _MemberSmsScreenState();
}

class _MemberSmsScreenState extends State<MemberSmsScreen> {
  bool _isLoading = false;

  Future<void> _loadContactsAndCompose() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final contacts = await ContactService.getSimContacts();
      final grouped = ContactService.groupByCarrier(contacts);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactsScreen(
              groupedContacts: grouped,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Campaign'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SMS Gateway Balance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<double>(
                      future: SmsGatewayService.getBalance(),
                      builder: (context, snapshot) {
                        final balance = snapshot.data ?? 0.0;
                        return Text(
                          'NPR ${balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Show package purchase dialog
                      },
                      child: const Text('Purchase Package'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'SMS Costs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildCostRow('NTC', SmsGatewayService.getSmsCosts()['NTC'] ?? 0.0),
                    _buildCostRow('Ncell', SmsGatewayService.getSmsCosts()['Ncell'] ?? 0.0),
                    _buildCostRow('Smart', SmsGatewayService.getSmsCosts()['Smart'] ?? 0.0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _loadContactsAndCompose,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.message),
              label: const Text('Compose SMS'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostRow(String carrier, double cost) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(carrier),
          Text(
            'NPR ${cost.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

