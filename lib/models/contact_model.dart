class ContactModel {
  final String name;
  final String phoneNumber;
  final String carrier;
  bool isSelected;

  ContactModel({
    required this.name,
    required this.phoneNumber,
    required this.carrier,
    this.isSelected = false,
  });

  ContactModel copyWith({
    String? name,
    String? phoneNumber,
    String? carrier,
    bool? isSelected,
  }) {
    return ContactModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      carrier: carrier ?? this.carrier,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

