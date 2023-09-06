// To parse this JSON data, do
//
//     final userBill = userBillFromJson(jsonString);

import 'dart:convert';

UserBill userBillFromJson(String str) => UserBill.fromJson(json.decode(str));

String userBillToJson(UserBill data) => json.encode(data.toJson());

class UserBill {
  String message;
  bool success;
  List<Map<String, String?>> monthlyBill;
  int totalAmount;

  UserBill({
    required this.message,
    required this.success,
    required this.monthlyBill,
    required this.totalAmount,
  });

  factory UserBill.fromJson(Map<String, dynamic> json) => UserBill(
        message: json["Message"],
        success: json["Success"],
        monthlyBill: List<Map<String, String?>>.from(json["monthlyBill"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
        totalAmount: json["TotalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "monthlyBill": List<dynamic>.from(monthlyBill.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "TotalAmount": totalAmount,
      };
}
