import 'package:flutter/material.dart';

import '../core/models/contents_list_response.dart';

/// Reusable content card (image, title, textContent, party) used in
/// MemberDashboardScreen and PushHistoryScreen.
class ContentCardWidget extends StatelessWidget {
  final ContentItem content;
  final Widget? trailing;

  const ContentCardWidget({
    super.key,
    required this.content,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
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
                if (trailing != null) ...[
                  const SizedBox(height: 16),
                  trailing!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
