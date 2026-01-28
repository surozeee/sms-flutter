import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:social_sharing_plus/social_sharing_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service to handle social media sharing
class ShareService {
  /// Helper to download and prepare image file for sharing
  static Future<String?> _prepareFile(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return null;

    try {
      // Build full URL if it's a relative path
      String fullUrl = imageUrl;
      if (!imageUrl.startsWith('http')) {
        fullUrl = 'https://loksandesh.jojolapatech.com/$imageUrl';
      }

      print('Downloading image from: $fullUrl');
      final response = await http.get(Uri.parse(fullUrl));
      
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final path = '${directory.path}/temp_share_image_$timestamp.png';
        final file = File(path);
        await file.writeAsBytes(response.bodyBytes);
        
        // Verify file was created
        if (await file.exists()) {
          print('Image saved to: $path');
          return path;
        } else {
          print('Error: File was not created');
          return null;
        }
      } else {
        print('Error downloading image: Status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error preparing image file: $e');
      return null;
    }
  }

  /// Share to specific social platform
  static Future<void> shareTo(SocialPlatform platform,
      {String? imageUrl, required String text}) async {
    try {
      String? localPath = await _prepareFile(imageUrl);

      if (localPath != null && await File(localPath).exists()) {
        // Share with image
        print('Sharing to $platform with image: $localPath');
        await SocialSharingPlus.shareToSocialMedia(
          platform,
          text,
          media: localPath,
          isOpenBrowser: true,
        );
      } else {
        // Share text only if image download failed
        print('Sharing to $platform text only (no image)');
        await SocialSharingPlus.shareToSocialMedia(
          platform,
          text,
          isOpenBrowser: true,
        );
      }
    } catch (e) {
      print('Error sharing to $platform: $e');
      // Don't rethrow, just log the error
      // The user can still use the general share button
    }
  }

  /// Viber requires a manual URI launch
  static Future<void> shareToViber(
      {String? imageUrl, required String text}) async {
    try {
      // Viber doesn't have direct support in social_sharing_plus, use URI launch
      final viberUrl =
          Uri.parse("viber://forward?text=${Uri.encodeComponent(text)}");
      if (await canLaunchUrl(viberUrl)) {
        await launchUrl(viberUrl, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Viber is not installed');
      }
    } catch (e) {
      print('Error sharing to Viber: $e');
      rethrow;
    }
  }
}
