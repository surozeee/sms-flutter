import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/services/profile_cache_service.dart';
import '../../services/sms_gateway_service.dart';
import '../packages/package_list_screen.dart';

class MemberSmsScreen extends ConsumerStatefulWidget {
  const MemberSmsScreen({super.key});

  @override
  ConsumerState<MemberSmsScreen> createState() => _MemberSmsScreenState();
}

class _MemberSmsScreenState extends ConsumerState<MemberSmsScreen> {
  Future<void> _refreshBalance() async {
    try {
      // Fetch profile from API to update cache
      final profileNotifier = ref.read(userProfileProviderProvider.notifier);
      await profileNotifier.refreshProfile();
      // Trigger rebuild to show updated balance
      setState(() {});
    } catch (e) {
      // Error handling is done by the provider
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SMS Gateway Balance',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: _refreshBalance,
                          tooltip: 'Refresh Balance',
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<double>(
                      future: ProfileCacheService.getBalance(),
                      builder: (context, snapshot) {
                        final balance = snapshot.data ?? 0.0;
                        return Text(
                          'Rs. ${balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PackageListScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text('Purchase Package'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
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

