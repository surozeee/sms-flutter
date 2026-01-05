class MemberModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? mpin;
  final DateTime? createdAt;
  final bool isActive;

  MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.mpin,
    this.createdAt,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'mpin': mpin,
      'createdAt': createdAt?.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      mpin: json['mpin'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      isActive: json['isActive'] ?? true,
    );
  }
}

