import 'dart:convert';

DailyNeedProductList dailyNeedProductListFromJson(String str) =>
    DailyNeedProductList.fromJson(json.decode(str));

String dailyNeedProductListToJson(DailyNeedProductList data) =>
    json.encode(data.toJson());

class DailyNeedProductList {
  String message;
  bool success;
  List<DialNeedList> dialNeedList;

  DailyNeedProductList({
    required this.message,
    required this.success,
    required this.dialNeedList,
  });

  factory DailyNeedProductList.fromJson(Map<String, dynamic> json) =>
      DailyNeedProductList(
        message: json["Message"],
        success: json["Success"],
        dialNeedList: List<DialNeedList>.from(
            json["dialNeedList"].map((x) => DialNeedList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "dialNeedList": List<dynamic>.from(dialNeedList.map((x) => x.toJson())),
      };
}

class DialNeedList {
  String customerId;
  String name;
  DateTime createdAt;
  String contact;
  String email;
  String address;
  String orderId;
  List<dynamic> otherCharges;
  List<Productdetail> productdetails;

  DialNeedList({
    required this.customerId,
    required this.name,
    required this.createdAt,
    required this.contact,
    required this.email,
    required this.address,
    required this.orderId,
    required this.otherCharges,
    required this.productdetails,
  });

  factory DialNeedList.fromJson(Map<String, dynamic> json) => DialNeedList(
        customerId: json["customer_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        contact: json["contact"],
        email: json["email"],
        address: json["address"],
        orderId: json["order_id"],
        otherCharges: List<dynamic>.from(json["other_charges"].map((x) => x)),
        productdetails: List<Productdetail>.from(
            json["productdetails"].map((x) => Productdetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "name": name,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "contact": contact,
        "email": email,
        "address": address,
        "order_id": orderId,
        "other_charges": List<dynamic>.from(otherCharges.map((x) => x)),
        "productdetails":
            List<dynamic>.from(productdetails.map((x) => x.toJson())),
      };
}

class Productdetail {
  String id;
  String orderId;
  String customerId;
  String productId;
  dynamic qnt;
  dynamic userId;
  String? unitId;
  dynamic rate;
  String raiseDispute;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String? unitName;
  dynamic productName;

  Productdetail({
    required this.id,
    required this.orderId,
    required this.customerId,
    required this.productId,
    required this.qnt,
    this.userId,
    required this.unitId,
    required this.rate,
    required this.raiseDispute,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.unitName,
    this.productName,
  });

  factory Productdetail.fromJson(Map<String, dynamic> json) => Productdetail(
        id: json["id"],
        orderId: json["order_id"],
        customerId: json["customer_id"],
        productId: json["product_id"],
        qnt: json["qnt"],
        userId: json["staff_id"],
        unitId: json["unit_id"],
        rate: json["rate"],
        raiseDispute: json["raise_dispute"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        unitName: json["unit_name"],
        productName: json["product_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "customer_id": customerId,
        "product_id": productId,
        "qnt": qnt,
        "staff_id": userId,
        "unit_id": unitId,
        "rate": rate,
        "raise_dispute": raiseDispute,
        "status": status,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt.toIso8601String(),
        "unit_name": unitName,
        "product_name": productName,
      };
}
