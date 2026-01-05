import 'package:flutter/material.dart';

class MemberStatsScreen extends StatefulWidget {
  const MemberStatsScreen({super.key});

  @override
  State<MemberStatsScreen> createState() => _MemberStatsScreenState();
}

class _MemberStatsScreenState extends State<MemberStatsScreen> {
  int _postsShared = 0;
  int _messagesSent = 0;
  int _newContacts = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    // Load statistics
    // In a real app, these would be tracked separately
    setState(() {
      _postsShared = 0; // TODO: Track from content shares
      _messagesSent = 0; // TODO: Track from SMS sends
      _newContacts = 0; // TODO: Track new contacts added
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatCard('Posts Shared', _postsShared.toString(), Icons.share, Colors.blue),
            const SizedBox(height: 16),
            _buildStatCard('Messages Sent', _messagesSent.toString(), Icons.message, Colors.green),
            const SizedBox(height: 16),
            _buildStatCard('New Contacts Added', _newContacts.toString(), Icons.person_add, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

