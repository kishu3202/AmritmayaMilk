//Daily need Product List data model class

class ProductList {
  String message;
  bool success;
  List<ProductListElement> productList;

  ProductList(
      {required this.success,
      required this.message,
      required this.productList});

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        success: json['Success'],
        message: json['Message'],
        productList: List<ProductListElement>.from(
            json['productList'].map((x) => ProductListElement.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "productList": List<dynamic>.from(productList.map((x) => x.toJson())),
      };
}

class ProductListElement {
  String id;
  String name;
  String unitId;
  DateTime createdAt;
  DateTime updatedAt;
  String unitName;
  ProductListElement({
    required this.id,
    required this.name,
    required this.unitId,
    required this.createdAt,
    required this.updatedAt,
    required this.unitName,
  });
  factory ProductListElement.fromJson(Map<String, dynamic> json) =>
      ProductListElement(
        id: json["id"],
        name: json["name"],
        unitId: json["unit_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        unitName: json["unit_name"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unit_id": unitId,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt.toIso8601String(),
        "unit_name": unitName,
      };
}
