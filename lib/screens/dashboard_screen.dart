import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/contact_service.dart';
import '../services/auth_service.dart';
import '../services/stats_service.dart';
import '../services/language_service.dart';
import '../models/contact_model.dart';
import 'contacts_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'image_share_screen.dart';
import 'advanced_search_screen.dart';
import 'sms_menu_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  int _smsSentCount = 0;
  int _todaySentCount = 0;
  bool _isLoading = false;
  bool _hasPermission = false;
  String _currentLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadStats();
    _checkPermissions();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final lang = await LanguageService.getCurrentLanguage();
    setState(() {
      _currentLanguage = lang;
    });
  }

  Future<void> _loadStats() async {
    final totalCount = await StatsService.getSmsSentCount();
    final todayCount = await StatsService.getTodaySentCount();
    setState(() {
      _smsSentCount = totalCount;
      _todaySentCount = todayCount;
    });
  }

  Future<void> _checkPermissions() async {
    final contactsPermission = await Permission.contacts.status;
    final smsPermission = await Permission.sms.status;

    if (contactsPermission.isGranted && smsPermission.isGranted) {
      setState(() {
        _hasPermission = true;
      });
    }
  }

  Future<void> _requestPermissions() async {
    final contactsStatus = await Permission.contacts.request();
    final smsStatus = await Permission.sms.request();

    if (contactsStatus.isGranted && smsStatus.isGranted) {
      setState(() {
        _hasPermission = true;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permissions are required to use this app'),
            action: SnackBarAction(
              label: 'Open Settings',
              onPressed: openAppSettings,
            ),
          ),
        );
      }
    }
  }

  Future<void> _loadContacts() async {
    if (!_hasPermission) {
      await _requestPermissions();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      List<ContactModel> contacts = await ContactService.getSimContacts();
      Map<String, List<ContactModel>> groupedContacts =
          ContactService.groupByCarrier(contacts);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactsScreen(
              groupedContacts: groupedContacts,
            ),
          ),
        ).then((_) {
          // Reload stats when returning from contacts screen
          _loadStats();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading contacts: $e')),
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
      await AuthService.logout();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    }
  }

  Future<void> _shareApp() async {
    const shareText = 'Check out this amazing SMS App! Download now.';
    await Share.share(shareText);
  }

  Future<void> _openSocialMedia(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
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
                  FutureBuilder<String?>(
                    future: AuthService.getCurrentUsername(),
                    builder: (context, snapshot) {
                      final username = snapshot.data ?? 'User';
                      return Text(
                        '${LanguageService.translate('welcome', language: _currentLanguage)}, $username!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    LanguageService.translate('manage_campaigns', language: _currentLanguage),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  LanguageService.translate('sms_sent', language: _currentLanguage),
                  _smsSentCount.toString(),
                  Icons.send,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  LanguageService.translate('today', language: _currentLanguage),
                  _todaySentCount.toString(),
                  Icons.today,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Advanced Search Card
          Card(
            elevation: 2,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdvancedSearchScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.orange,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LanguageService.translate('advanced_search', language: _currentLanguage),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            LanguageService.translate('search_contacts', language: _currentLanguage),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Text(
            LanguageService.translate('quick_actions', language: _currentLanguage),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  LanguageService.translate('load_contacts', language: _currentLanguage),
                  Icons.contacts,
                  Colors.blue,
                  _loadContacts,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionCard(
                  LanguageService.translate('send_sms', language: _currentLanguage),
                  Icons.message,
                  Colors.green,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SmsMenuScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  LanguageService.translate('image_share', language: _currentLanguage),
                  Icons.image,
                  Colors.purple,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImageShareScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Social Media Section
          Text(
            LanguageService.translate('share_connect', language: _currentLanguage),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.share_outlined, color: Colors.blue),
                    title: Text(LanguageService.translate('share_app', language: _currentLanguage)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: _shareApp,
                  ),
                  const Divider(),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF1877F2)),
                    title: const Text('Facebook'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openSocialMedia('https://www.facebook.com'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF25D366)),
                    title: const Text('WhatsApp'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openSocialMedia('https://wa.me'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.viber, color: Color(0xFF665CAC)),
                    title: const Text('Viber'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openSocialMedia('https://www.viber.com'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.linkedin, color: Color(0xFF0077B5)),
                    title: const Text('LinkedIn'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openSocialMedia('https://www.linkedin.com'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.xTwitter, color: Color(0xFF1DA1F2)),
                    title: const Text('Twitter/X'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openSocialMedia('https://www.twitter.com'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.instagram, color: Color(0xFFE4405F)),
                    title: const Text('Instagram'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openSocialMedia('https://www.instagram.com'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageDialog() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LanguageService.translate('select_language', language: _currentLanguage)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: LanguageService.getAvailableLanguages().map((lang) {
            return ListTile(
              title: Text('${lang['name']} (${lang['native']})'),
              leading: Radio<String>(
                value: lang['code']!,
                groupValue: _currentLanguage,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              ),
              onTap: () {
                Navigator.pop(context, lang['code']);
              },
            );
          }).toList(),
        ),
      ),
    );

    if (selected != null) {
      await LanguageService.setLanguage(selected);
      setState(() {
        _currentLanguage = selected;
      });
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 32),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageService.translate('dashboard', language: _currentLanguage)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: LanguageService.translate('select_language', language: _currentLanguage),
            onPressed: _showLanguageDialog,
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
                    Icons.phone_android,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SMS App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FutureBuilder<String?>(
                    future: AuthService.getCurrentUsername(),
                    builder: (context, snapshot) {
                      final username = snapshot.data ?? 'User';
                      return Text(
                        username,
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
              title: Text(LanguageService.translate('dashboard', language: _currentLanguage)),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: Text(LanguageService.translate('contacts', language: _currentLanguage)),
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
                _loadContacts();
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: Text(LanguageService.translate('send_sms', language: _currentLanguage)),
              selected: _selectedIndex == 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SmsMenuScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: Text(LanguageService.translate('statistics', language: _currentLanguage)),
              selected: _selectedIndex == 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: Text(LanguageService.translate('image_share', language: _currentLanguage)),
              selected: _selectedIndex == 4,
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImageShareScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: Text(LanguageService.translate('share_app', language: _currentLanguage)),
              onTap: () {
                Navigator.pop(context);
                _shareApp();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(LanguageService.translate('settings', language: _currentLanguage)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                LanguageService.translate('logout', language: _currentLanguage),
                style: const TextStyle(color: Colors.red),
              ),
              onTap: _handleLogout,
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildDashboard(),
    );
  }
}

