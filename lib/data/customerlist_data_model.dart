class DataModel {
  late final id;
  late final String name;
  late final String email;
  late final String contact;
  late final String address;
  DataModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.contact,
      required this.address});
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      contact: json['contact'] ?? "",
      address: json['address'] ?? "",
    );
  }
}
