// To parse this JSON data, do
//
//     final outSatandingAmount = outSatandingAmountFromJson(jsonString);

import 'dart:convert';

OutSatandingAmount outSatandingAmountFromJson(String str) =>
    OutSatandingAmount.fromJson(json.decode(str));

String outSatandingAmountToJson(OutSatandingAmount data) =>
    json.encode(data.toJson());

class OutSatandingAmount {
  String message;
  bool success;
  String outstandingamount;
  String totalpayamount;

  OutSatandingAmount({
    required this.message,
    required this.success,
    required this.outstandingamount,
    required this.totalpayamount,
  });

  factory OutSatandingAmount.fromJson(Map<String, dynamic> json) =>
      OutSatandingAmount(
        message: json["Message"],
        success: json["Success"],
        outstandingamount: json["outstandingamount"],
        totalpayamount: json["totalpayamount"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "outstandingamount": outstandingamount,
        "totalpayamount": totalpayamount,
      };
}
