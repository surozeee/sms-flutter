import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/content_model.dart';

class ContentService {
  static const String _contentsKey = 'contents';

  /// Create new content
  static Future<bool> createContent(ContentModel content) async {
    final prefs = await SharedPreferences.getInstance();
    final contentsJson = prefs.getString(_contentsKey);
    Map<String, dynamic> contents = {};
    
    if (contentsJson != null) {
      contents = Map<String, dynamic>.from(json.decode(contentsJson));
    }
    
    contents[content.id] = content.toJson();
    await prefs.setString(_contentsKey, json.encode(contents));
    return true;
  }

  /// Get all contents
  static Future<List<ContentModel>> getAllContents() async {
    final prefs = await SharedPreferences.getInstance();
    final contentsJson = prefs.getString(_contentsKey);
    if (contentsJson == null) return [];
    
    final contents = Map<String, dynamic>.from(json.decode(contentsJson));
    return contents.values
        .map((data) => ContentModel.fromJson(data as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get content by ID
  static Future<ContentModel?> getContentById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final contentsJson = prefs.getString(_contentsKey);
    if (contentsJson == null) return null;
    
    final contents = Map<String, dynamic>.from(json.decode(contentsJson));
    if (contents.containsKey(id)) {
      return ContentModel.fromJson(contents[id] as Map<String, dynamic>);
    }
    return null;
  }

  /// Increment view count
  static Future<void> incrementViews(String contentId) async {
    final content = await getContentById(contentId);
    if (content != null) {
      final updated = content.copyWith(views: content.views + 1);
      await createContent(updated);
    }
  }

  /// Increment share count
  static Future<void> incrementShares(String contentId) async {
    final content = await getContentById(contentId);
    if (content != null) {
      final updated = content.copyWith(shares: content.shares + 1);
      await createContent(updated);
    }
  }

  /// Delete content
  static Future<bool> deleteContent(String contentId) async {
    final prefs = await SharedPreferences.getInstance();
    final contentsJson = prefs.getString(_contentsKey);
    if (contentsJson == null) return false;
    
    final contents = Map<String, dynamic>.from(json.decode(contentsJson));
    contents.remove(contentId);
    await prefs.setString(_contentsKey, json.encode(contents));
    return true;
  }
}

