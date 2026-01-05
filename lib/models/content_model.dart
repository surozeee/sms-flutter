class ContentModel {
  final String id;
  final String title;
  final String? text;
  final String? imageUrl;
  final String? videoUrl;
  final String contentType; // 'text', 'image', 'video'
  final String createdBy; // admin id
  final DateTime createdAt;
  final int views;
  final int shares;

  ContentModel({
    required this.id,
    required this.title,
    this.text,
    this.imageUrl,
    this.videoUrl,
    required this.contentType,
    required this.createdBy,
    required this.createdAt,
    this.views = 0,
    this.shares = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'contentType': contentType,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'views': views,
      'shares': shares,
    };
  }

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      text: json['text'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      contentType: json['contentType'] ?? 'text',
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      views: json['views'] ?? 0,
      shares: json['shares'] ?? 0,
    );
  }

  ContentModel copyWith({
    String? id,
    String? title,
    String? text,
    String? imageUrl,
    String? videoUrl,
    String? contentType,
    String? createdBy,
    DateTime? createdAt,
    int? views,
    int? shares,
  }) {
    return ContentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      contentType: contentType ?? this.contentType,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      views: views ?? this.views,
      shares: shares ?? this.shares,
    );
  }
}

