import 'dart:convert';

SupportDataModel supportDataModelFromJson(String str) =>
    SupportDataModel.fromJson(json.decode(str));

String supportDataModelToJson(SupportDataModel data) =>
    json.encode(data.toJson());

class SupportDataModel {
  String message;
  bool success;
  List<SupportList> supportList;

  SupportDataModel({
    required this.message,
    required this.success,
    required this.supportList,
  });

  factory SupportDataModel.fromJson(Map<String, dynamic> json) =>
      SupportDataModel(
        message: json["Message"],
        success: json["Success"],
        supportList: List<SupportList>.from(
            json["supportList"].map((x) => SupportList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "supportList": List<dynamic>.from(supportList.map((x) => x.toJson())),
      };
}

class SupportList {
  String id;
  String email;
  String mobile;
  String disclaimer;

  SupportList({
    required this.id,
    required this.email,
    required this.mobile,
    required this.disclaimer,
  });

  factory SupportList.fromJson(Map<String, dynamic> json) => SupportList(
        id: json["id"],
        email: json["email"],
        mobile: json["mobile"],
        disclaimer: json["disclaimer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "mobile": mobile,
        "disclaimer": disclaimer,
      };
}
