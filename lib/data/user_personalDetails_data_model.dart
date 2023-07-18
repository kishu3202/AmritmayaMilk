class UserProfileDataModel {
  late final String userName;
  late final String userEmail;
  late final String userContact;
  late final String userAddress;
  UserProfileDataModel(
      {required this.userName,
      required this.userEmail,
      required this.userContact,
      required this.userAddress});
  factory UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDataModel(
      userName: json['name'] ?? "",
      userEmail: json['email'] ?? "",
      userContact: json['contact'] ?? "",
      userAddress: json['address'] ?? "",
    );
  }
}
