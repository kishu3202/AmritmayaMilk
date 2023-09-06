import 'dart:convert';

ProductRateList productRateListFromJson(String str) =>
    ProductRateList.fromJson(json.decode(str));

String productRateListToJson(ProductRateList data) =>
    json.encode(data.toJson());

class ProductRateList {
  String message;
  bool success;
  ProductrateList productrateList;

  ProductRateList({
    required this.message,
    required this.success,
    required this.productrateList,
  });

  factory ProductRateList.fromJson(Map<String, dynamic> json) =>
      ProductRateList(
        message: json["Message"],
        success: json["Success"],
        productrateList: ProductrateList.fromJson(json["productrateList"]),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "productrateList": productrateList.toJson(),
      };
}

class ProductrateList {
  String rate;

  ProductrateList({
    required this.rate,
  });

  factory ProductrateList.fromJson(Map<String, dynamic> json) =>
      ProductrateList(
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
      };
}
