import 'dart:convert';

ProductUnitList productUnitListFromJson(String str) =>
    ProductUnitList.fromJson(json.decode(str));

String productUnitListToJson(ProductUnitList data) =>
    json.encode(data.toJson());

class ProductUnitList {
  String message;
  bool success;
  List<ProductunitList> productunitList;

  ProductUnitList({
    required this.message,
    required this.success,
    required this.productunitList,
  });

  factory ProductUnitList.fromJson(Map<String, dynamic> json) =>
      ProductUnitList(
        message: json["Message"],
        success: json["Success"],
        productunitList: List<ProductunitList>.from(
            json["productunitList"].map((x) => ProductunitList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "productunitList":
            List<dynamic>.from(productunitList.map((x) => x.toJson())),
      };
}

class ProductunitList {
  String unitId;
  String name;

  ProductunitList({
    required this.unitId,
    required this.name,
  });

  factory ProductunitList.fromJson(Map<String, dynamic> json) =>
      ProductunitList(
        unitId: json["unit_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "unit_id": unitId,
        "name": name,
      };
}
