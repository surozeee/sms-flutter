import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/auth_provider.dart';
import '../auth/role_selection_screen.dart';
import 'admin_sms_screen.dart';
import 'content_management_screen.dart';
import 'member_management_screen.dart';
import 'push_history_screen.dart';
import '../../screens/packages/package_list_screen.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  int _selectedIndex = 0;

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Use the logout provider to clear cached login data
      await ref.read(logoutProvider.notifier).logout();

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const RoleSelectionScreen(),
          ),
          (route) => false, // Remove all previous routes
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header with Profile Info
            Consumer(
              builder: (context, ref, child) {
                final profileAsync = ref.watch(userProfileProviderProvider);

                return DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.admin_panel_settings,
                        size: 48,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      profileAsync.when(
                        data: (profile) {
                          // Get display name with fallback: fullName -> emailAddress -> mobileNumber -> 'Admin'
                          final displayName = profile?.fullName?.isNotEmpty ==
                                  true
                              ? profile!.fullName!
                              : (profile?.emailAddress?.isNotEmpty == true
                                  ? profile!.emailAddress!
                                  : (profile?.mobileNumber?.isNotEmpty == true
                                      ? profile!.mobileNumber!
                                      : 'Admin'));
                          final roleName = (profile?.roleName ?? 'ADMIN')
                              .replaceAll('_', ' ');

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                roleName,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () => const Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        error: (_, __) => const Text(
                          'Admin',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Balance Section
            Consumer(
              builder: (context, ref, child) {
                final balanceAsync = ref.watch(userBalanceProvider);
                final profileNotifier = ref.read(userProfileProviderProvider.notifier);

                Future<void> refreshBalance() async {
                  try {
                    // Fetch profile from API to update cache
                    await profileNotifier.refreshProfile();
                    // Invalidate balance provider to refetch from updated cache
                    ref.invalidate(userBalanceProvider);
                  } catch (e) {
                    // Error handling is done by the provider
                  }
                }

                return Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Balance',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: refreshBalance,
                            tooltip: 'Refresh Balance',
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      balanceAsync.when(
                        data: (balance) => Text(
                          'Rs. ${balance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (_, __) => Text(
                          'Rs. 0.00',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
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
                          label: const Text('Add Credit'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Member Management'),
              selected: _selectedIndex == 1,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberManagementScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Create Content'),
              selected: _selectedIndex == 2,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContentManagementScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Push History'),
              selected: _selectedIndex == 3,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PushHistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Send SMS'),
              selected: _selectedIndex == 4,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminSmsScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: _handleLogout,
            ),
          ],
        ),
      ),
      body: _buildDashboard(),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primaryContainer,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final profileAsync =
                          ref.watch(userProfileProviderProvider);

                      return profileAsync.when(
                        data: (profile) {
                          // Get display name with fallback: fullName -> emailAddress -> mobileNumber -> 'Admin'
                          final displayName = profile?.fullName?.isNotEmpty ==
                                  true
                              ? profile!.fullName!
                              : (profile?.emailAddress?.isNotEmpty == true
                                  ? profile!.emailAddress!
                                  : (profile?.mobileNumber?.isNotEmpty == true
                                      ? profile!.mobileNumber!
                                      : 'Admin'));
                          final roleName = (profile?.roleName ?? 'ADMIN')
                              .replaceAll('_', ' ');

                          return Text(
                            'Welcome, $displayName ($roleName) !',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        },
                        loading: () => const Text(
                          'Welcome, Admin!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        error: (_, __) => const Text(
                          'Welcome, Admin!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Campaign Management Dashboard',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildActionCard(
                'Member Management',
                Icons.people,
                Colors.blue,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MemberManagementScreen(),
                    ),
                  );
                },
              ),
              _buildActionCard(
                'Create Content',
                Icons.create,
                Colors.green,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContentManagementScreen(),
                    ),
                  );
                },
              ),
              _buildActionCard(
                'Push History',
                Icons.history,
                Colors.orange,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PushHistoryScreen(),
                    ),
                  );
                },
              ),
              _buildActionCard(
                'Send SMS',
                Icons.message,
                Colors.red,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminSmsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
