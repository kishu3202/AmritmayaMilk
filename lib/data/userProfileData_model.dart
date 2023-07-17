class UserProfileDataModel {
  late final String name;
  late final String email;
  late final String contact;
  late final String address;
  UserProfileDataModel(
      {required this.name,
      required this.email,
      required this.contact,
      required this.address});
  factory UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDataModel(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      contact: json['contact'] ?? "",
      address: json['address'] ?? "",
    );
  }
}
