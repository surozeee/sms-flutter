import 'package:flutter/material.dart';
import '../../services/content_service.dart';
import '../../models/content_model.dart';

class PushHistoryScreen extends StatefulWidget {
  const PushHistoryScreen({super.key});

  @override
  State<PushHistoryScreen> createState() => _PushHistoryScreenState();
}

class _PushHistoryScreenState extends State<PushHistoryScreen> {
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
      setState(() {
        _contents = contents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _contents.isEmpty
              ? const Center(
                  child: Text('No content pushed yet'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _contents.length,
                  itemBuilder: (context, index) {
                    final content = _contents[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(
                          content.contentType == 'image'
                              ? Icons.image
                              : content.contentType == 'video'
                                  ? Icons.video_library
                                  : Icons.text_fields,
                        ),
                        title: Text(content.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Type: ${content.contentType}'),
                            Text('Views: ${content.views} | Shares: ${content.shares}'),
                            Text('Created: ${content.createdAt.toString().split('.')[0]}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

