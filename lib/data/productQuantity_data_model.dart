import 'dart:convert';

ProductQuantityList productQuantityListFromJson(String str) =>
    ProductQuantityList.fromJson(json.decode(str));

String productQuantityListToJson(ProductQuantityList data) =>
    json.encode(data.toJson());

class ProductQuantityList {
  String message;
  bool success;
  List<ProductqntList> productqntList;

  ProductQuantityList({
    required this.message,
    required this.success,
    required this.productqntList,
  });

  factory ProductQuantityList.fromJson(Map<String, dynamic> json) =>
      ProductQuantityList(
        message: json["Message"],
        success: json["Success"],
        productqntList: List<ProductqntList>.from(
            json["productqntList"].map((x) => ProductqntList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "productqntList":
            List<dynamic>.from(productqntList.map((x) => x.toJson())),
      };
}

class ProductqntList {
  String qnt;

  ProductqntList({
    required this.qnt,
  });

  factory ProductqntList.fromJson(Map<String, dynamic> json) => ProductqntList(
        qnt: json["qnt"],
      );

  Map<String, dynamic> toJson() => {
        "qnt": qnt,
      };
}
