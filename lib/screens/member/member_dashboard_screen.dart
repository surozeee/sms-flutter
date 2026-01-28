import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_sharing_plus/social_sharing_plus.dart';

import '../../core/models/contents_list_response.dart';
import '../../core/providers/auth_provider.dart';
import '../../services/share_service.dart';
import '../auth/role_selection_screen.dart';
import '../packages/package_list_screen.dart';
import 'member_contacts_screen.dart';
import 'member_sms_screen.dart';

class MemberDashboardScreen extends ConsumerStatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  ConsumerState<MemberDashboardScreen> createState() =>
      _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends ConsumerState<MemberDashboardScreen> {
  List<ContentItem> _contents = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Defer the call until after the first build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadContents();
    });
  }

  Future<void> _loadContents() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final contentsListNotifier = ref.read(contentsListProvider.notifier);
      final response = await contentsListNotifier.fetchContents(
        page: 0,
        size: 10,
      );

      if (response.status == 'SUCCESS' && response.data != null) {
        setState(() {
          _contents = response.data!.content ?? [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Failed to load contents';
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } on DioException catch (e) {
      // Extract error message from response
      String errorMsg = 'Failed to load contents';
      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          errorMsg = data['message'] as String? ??
              data['error'] as String? ??
              data['errorMessage'] as String? ??
              e.message ??
              errorMsg;
        } else if (data is String) {
          errorMsg = data;
        } else if (e.message != null) {
          errorMsg = e.message!;
        }
      } else if (e.message != null) {
        errorMsg = e.message!;
      }

      setState(() {
        _errorMessage = errorMsg;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _shareContent(ContentItem content, String platform) async {
    String shareText = content.title ?? '';
    if (content.textContent != null && content.textContent!.isNotEmpty) {
      shareText += '\n\n${content.textContent}';
    }

    // Build image URL - if it's a relative path, prepend base URL
    String? imageUrl = content.imageUrl;
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl = 'https://loksandesh.jojolapatech.com/$imageUrl';
    }

    try {
      switch (platform) {
        case 'facebook':
          await ShareService.shareTo(
            SocialPlatform.facebook,
            imageUrl: imageUrl,
            text: shareText,
          );
          break;
        case 'whatsapp':
          await ShareService.shareTo(
            SocialPlatform.whatsapp,
            imageUrl: imageUrl,
            text: shareText,
          );
          break;
        case 'viber':
          await ShareService.shareToViber(
            imageUrl: imageUrl,
            text: shareText,
          );
          break;
        case 'linkedin':
          await ShareService.shareTo(
            SocialPlatform.linkedin,
            imageUrl: imageUrl,
            text: shareText,
          );
          break;
        case 'twitter':
          await ShareService.shareTo(
            SocialPlatform.twitter,
            imageUrl: imageUrl,
            text: shareText,
          );
          break;
        case 'instagram':
          // Instagram doesn't have direct support, use general share
          await Share.share(shareText);
          break;
        default:
          // Use share_plus for general sharing
          await Share.share(shareText);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _shareContentGeneral(ContentItem content) async {
    String shareText = content.title ?? '';
    if (content.textContent != null && content.textContent!.isNotEmpty) {
      shareText += '\n\n${content.textContent}';
    }

    // Build image URL - if it's a relative path, prepend base URL
    String? imageUrl = content.imageUrl;
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl = 'https://loksandesh.jojolapatech.com/$imageUrl';
    }

    try {
      // Use share_plus for general sharing (opens system share sheet)
      if (imageUrl != null) {
        // Download image and share with XFile
        try {
          final response = await http.get(Uri.parse(imageUrl));
          if (response.statusCode == 200) {
            final directory = await getTemporaryDirectory();
            final path =
                '${directory.path}/temp_share_${DateTime.now().millisecondsSinceEpoch}.png';
            final file = File(path);
            await file.writeAsBytes(response.bodyBytes);

            if (await file.exists()) {
              await Share.shareXFiles(
                [XFile(path)],
                text: shareText,
              );
              return;
            }
          }
        } catch (e) {
          print('Error downloading image for general share: $e');
          // Fall through to text-only share
        }
      }

      // Share text only if image download failed or no image
      await Share.share(shareText);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: Colors.red,
          ),
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
        title: const Text('LokSandesh'),
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
                          final displayName = profile?.fullName?.isNotEmpty ==
                                  true
                              ? profile!.fullName!
                              : (profile?.emailAddress?.isNotEmpty == true
                                  ? profile!.emailAddress!
                                  : (profile?.mobileNumber?.isNotEmpty == true
                                      ? profile!.mobileNumber!
                                      : 'Member'));
                          final roleName = (profile?.roleName ?? 'MEMBER')
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
                final profileNotifier =
                    ref.read(userProfileProviderProvider.notifier);

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
                            _errorMessage ?? 'No content available',
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

  Widget _buildContentCard(ContentItem content) {
    // Build image URL - if it's a relative path, prepend base URL
    String? imageUrl = content.imageUrl;
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl = 'https://loksandesh.jojolapatech.com/$imageUrl';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
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
                  content.title ?? 'Untitled',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (content.textContent != null &&
                    content.textContent!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    content.textContent!,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
                if (content.partyName != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Party: ${content.partyName}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
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
                    _buildGeneralShareButton(content),
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
    ContentItem content,
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

  Widget _buildGeneralShareButton(ContentItem content) {
    return Tooltip(
      message: 'Share',
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: const Icon(Icons.share, size: 24),
          color: Colors.grey.shade700,
          iconSize: 28,
          onPressed: () => _shareContentGeneral(content),
        ),
      ),
    );
  }
}
