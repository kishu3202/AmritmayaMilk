import 'dart:convert';

OtherCharges otherChargesFromJson(String str) => OtherCharges.fromJson(json.decode(str));

String otherChargesToJson(OtherCharges data) => json.encode(data.toJson());

class OtherCharges {
  String message;
  bool success;
  List<Othercharge> othercharges;

  OtherCharges({
    required this.message,
    required this.success,
    required this.othercharges,
  });

  factory OtherCharges.fromJson(Map<String, dynamic> json) => OtherCharges(
    message: json["Message"],
    success: json["Success"],
    othercharges: List<Othercharge>.from(json["othercharges"].map((x) => Othercharge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Success": success,
    "othercharges": List<dynamic>.from(othercharges.map((x) => x.toJson())),
  };
}

class Othercharge {
  String id;
  String name;
  String amount;

  Othercharge({
    required this.id,
    required this.name,
    required this.amount,
  });

  factory Othercharge.fromJson(Map<String, dynamic> json) => Othercharge(
    id: json["id"],
    name: json["name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "amount": amount,
  };
}
