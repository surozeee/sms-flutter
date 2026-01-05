import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/auth_service_v2.dart';
import '../../services/content_service.dart';
import '../../models/content_model.dart';
import '../auth/role_selection_screen.dart';
import 'member_contacts_screen.dart';
import 'member_sms_screen.dart';
import 'member_stats_screen.dart';

class MemberDashboardScreen extends StatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  State<MemberDashboardScreen> createState() => _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends State<MemberDashboardScreen> {
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
            Uri.parse('https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(shareText)}'),
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
      await AuthServiceV2.logout();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RoleSelectionScreen(),
          ),
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
            DrawerHeader(
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
                  const Text(
                    'Member',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder(
                    future: AuthServiceV2.getCurrentUser(),
                    builder: (context, snapshot) {
                      final name = snapshot.data?.name ?? 'Member';
                      return Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildShareButton('Facebook', Icons.people, Colors.blue, content),
                    _buildShareButton('Instagram', Icons.camera_alt, Colors.pink, content),
                    _buildShareButton('TikTok', Icons.music_note, Colors.black, content),
                    _buildShareButton('WhatsApp', Icons.chat, Colors.green, content),
                    _buildShareButton('Viber', Icons.message, Colors.purple, content),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.visibility, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text('${content.views}', style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(width: 16),
                    Icon(Icons.share, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text('${content.shares}', style: TextStyle(color: Colors.grey.shade600)),
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
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: () => _shareContent(content, platform.toLowerCase()),
      tooltip: platform,
    );
  }
}

