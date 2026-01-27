import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/providers/auth_provider.dart';
import '../../models/content_model.dart';
import '../../services/content_service.dart';
import '../auth/role_selection_screen.dart';
import '../packages/package_list_screen.dart';
import 'member_contacts_screen.dart';
import 'member_sms_screen.dart';
import 'member_stats_screen.dart';

class MemberDashboardScreen extends ConsumerStatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  ConsumerState<MemberDashboardScreen> createState() =>
      _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends ConsumerState<MemberDashboardScreen> {
  List<ContentModel> _contents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContents();
  }

  Future<void> _loadContents() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final contents = await ContentService.getAllContents();
      // Increment view count for each content
      for (var content in contents) {
        await ContentService.incrementViews(content.id);
      }
      // Reload to get updated view counts
      final updatedContents = await ContentService.getAllContents();
      setState(() {
        _contents = updatedContents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _shareContent(ContentModel content, String platform) async {
    // Increment share count
    await ContentService.incrementShares(content.id);

    String shareText = content.title;
    if (content.text != null) {
      shareText += '\n\n${content.text}';
    }

    try {
      switch (platform) {
        case 'facebook':
          await launchUrl(
            Uri.parse(
                'https://www.facebook.com/sharer/sharer.php?quote=${Uri.encodeComponent(shareText)}'),
            mode: LaunchMode.externalApplication,
          );
          break;
        case 'whatsapp':
          await launchUrl(
            Uri.parse('https://wa.me/?text=${Uri.encodeComponent(shareText)}'),
            mode: LaunchMode.externalApplication,
          );
          break;
        case 'viber':
          await launchUrl(
            Uri.parse('viber://forward?text=${Uri.encodeComponent(shareText)}'),
            mode: LaunchMode.externalApplication,
          );
          break;
        case 'linkedin':
          // LinkedIn share with text
          await launchUrl(
            Uri.parse(
                'https://www.linkedin.com/sharing/share-offsite/?mini=true&summary=${Uri.encodeComponent(shareText)}'),
            mode: LaunchMode.externalApplication,
          );
          break;
        case 'twitter':
          await launchUrl(
            Uri.parse(
                'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(shareText)}'),
            mode: LaunchMode.externalApplication,
          );
          break;
        case 'instagram':
          // Instagram doesn't support direct sharing via URL
          await Share.share(shareText);
          break;
        case 'tiktok':
          await Share.share(shareText);
          break;
        default:
          await Share.share(shareText);
      }

      // Reload contents to update share count
      _loadContents();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing: $e')),
        );
      }
    }
  }

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
        title: const Text('CampaignConnect'),
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
                        Icons.people,
                        size: 48,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      profileAsync.when(
                        data: (profile) {
                          // Get display name with fallback: fullName -> emailAddress -> mobileNumber -> 'Member'
                          final displayName = profile?.fullName?.isNotEmpty == true
                              ? profile!.fullName!
                              : (profile?.emailAddress?.isNotEmpty == true
                                  ? profile!.emailAddress!
                                  : (profile?.mobileNumber?.isNotEmpty == true
                                      ? profile!.mobileNumber!
                                      : 'Member'));
                          final roleName = (profile?.roleName ?? 'MEMBER').replaceAll('_', ' ');
                          
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
                          'Member',
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
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        loading: () => const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        error: (_, __) => Text(
                          'Rs. 0.00',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Contacts'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberContactsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('SMS Campaign'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberSmsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Statistics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberStatsScreen(),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadContents,
              child: _contents.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No content available',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _contents.length,
                      itemBuilder: (context, index) {
                        final content = _contents[index];
                        return _buildContentCard(content);
                      },
                    ),
            ),
    );
  }

  Widget _buildContentCard(ContentModel content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (content.imageUrl != null)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: content.imageUrl!.startsWith('http')
                  ? Image.network(
                      content.imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, size: 64),
                        );
                      },
                    )
                  : Image.file(
                      File(content.imageUrl!),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, size: 64),
                        );
                      },
                    ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (content.text != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    content.text!,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildShareButton('Facebook', FontAwesomeIcons.facebook,
                        const Color(0xFF1877F2), content),
                    _buildShareButton('WhatsApp', FontAwesomeIcons.whatsapp,
                        const Color(0xFF25D366), content),
                    _buildShareButton('Viber', FontAwesomeIcons.viber,
                        const Color(0xFF665CAC), content),
                    _buildShareButton('LinkedIn', FontAwesomeIcons.linkedin,
                        const Color(0xFF0077B5), content),
                    _buildShareButton('Twitter', FontAwesomeIcons.xTwitter,
                        const Color(0xFF1DA1F2), content),
                    _buildShareButton('Instagram', FontAwesomeIcons.instagram,
                        const Color(0xFFE4405F), content),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.visibility,
                        size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text('${content.views}',
                        style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(width: 16),
                    Icon(Icons.ios_share,
                        size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text('${content.shares}',
                        style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(
    String platform,
    IconData icon,
    Color color,
    ContentModel content,
  ) {
    return Tooltip(
      message: platform,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: FaIcon(icon, size: 24),
          color: color,
          iconSize: 28,
          onPressed: () => _shareContent(content, platform.toLowerCase()),
        ),
      ),
    );
  }
}
