import 'dart:convert';

ProductRateList productRateListFromJson(String str) =>
    ProductRateList.fromJson(json.decode(str));

String productRateListToJson(ProductRateList data) =>
    json.encode(data.toJson());

class ProductRateList {
  String message;
  bool success;
  List<ProductrateList> productrateList;

  ProductRateList({
    required this.message,
    required this.success,
    required this.productrateList,
  });

  factory ProductRateList.fromJson(Map<String, dynamic> json) =>
      ProductRateList(
        message: json["Message"],
        success: json["Success"],
        productrateList: List<ProductrateList>.from(
            json["productrateList"].map((x) => ProductrateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "productrateList":
            List<dynamic>.from(productrateList.map((x) => x.toJson())),
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
