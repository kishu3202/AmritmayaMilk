// import 'dart:convert';
//
// UserDailyNeedDetails userDailyNeedDetailsFromJson(String str) =>
//     UserDailyNeedDetails.fromJson(json.decode(str));
//
// String userDailyNeedDetailsToJson(UserDailyNeedDetails data) =>
//     json.encode(data.toJson());
//
// class UserDailyNeedDetails {
//   String message;
//   bool success;
//   List<DialNeedList> dialNeedList;
//
//   UserDailyNeedDetails({
//     required this.message,
//     required this.success,
//     required this.dialNeedList,
//   });
//
//   factory UserDailyNeedDetails.fromJson(Map<String, dynamic> json) =>
//       UserDailyNeedDetails(
//         message: json["Message"],
//         success: json["Success"],
//         dialNeedList: List<DialNeedList>.from(
//             json["dialNeedList"].map((x) => DialNeedList.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Message": message,
//         "Success": success,
//         "dialNeedList": List<dynamic>.from(dialNeedList.map((x) => x.toJson())),
//       };
// }
//
// class DialNeedList {
//   String customerId;
//   String orderId;
//   String name;
//   DateTime createdAt;
//   String contact;
//   String email;
//   String address;
//   String status;
//   List<OtherCharge> otherCharges;
//   List<Map<String, String?>> productdetails;
//
//   DialNeedList({
//     required this.customerId,
//     required this.orderId,
//     required this.name,
//     required this.createdAt,
//     required this.contact,
//     required this.email,
//     required this.address,
//     required this.status,
//     required this.otherCharges,
//     required this.productdetails,
//   });
//
//   int getProductCount() {
//     return productdetails.length;
//   }
//
//   factory DialNeedList.fromJson(Map<String, dynamic> json) => DialNeedList(
//         customerId: json["customer_id"],
//         orderId: json["order_id"],
//         name: json["name"],
//         createdAt: DateTime.parse(json["created_at"]),
//         contact: json["contact"],
//         email: json["email"],
//         address: json["address"],
//         status: json["status"],
//         otherCharges: List<OtherCharge>.from(
//             json["other_charges"].map((x) => OtherCharge.fromJson(x))),
//         productdetails: List<Map<String, String?>>.from(json["productdetails"]
//             .map((x) =>
//                 Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "customer_id": customerId,
//         "order_id": orderId,
//         "name": dialNeedListNameValues.reverse[name],
//         "created_at":
//             "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
//         "contact": contact,
//         "email": emailValues.reverse[email],
//         "address": addressValues.reverse[address],
//         "status": status,
//         "other_charges":
//             List<dynamic>.from(otherCharges.map((x) => x.toJson())),
//         "productdetails": List<dynamic>.from(productdetails.map(
//             (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//       };
// }
//
// enum Address { PUNE }
//
// final addressValues = EnumValues({"Pune": Address.PUNE});
//
// enum Email { KISHORI_GMAIL_COM }
//
// final emailValues = EnumValues({"kishori@gmail.com": Email.KISHORI_GMAIL_COM});
//
// enum DialNeedListName { KISHORI_PAWAR }
//
// final dialNeedListNameValues =
//     EnumValues({"Kishori Pawar": DialNeedListName.KISHORI_PAWAR});
//
// class OtherCharge {
//   String id;
//   String otherChargesId;
//   String customerId;
//   String orderId;
//   String amount;
//   DateTime createdAt;
//   OtherChargeName name;
//
//   OtherCharge({
//     required this.id,
//     required this.otherChargesId,
//     required this.customerId,
//     required this.orderId,
//     required this.amount,
//     required this.createdAt,
//     required this.name,
//   });
//
//   factory OtherCharge.fromJson(Map<String, dynamic> json) => OtherCharge(
//         id: json["id"],
//         otherChargesId: json["other_charges_id"],
//         customerId: json["customer_id"],
//         orderId: json["order_id"],
//         amount: json["amount"],
//         createdAt: DateTime.parse(json["created_at"]),
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "other_charges_id": otherChargesId,
//         "customer_id": customerId,
//         "order_id": orderId,
//         "amount": amount,
//         "created_at":
//             "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
//         "name": otherChargeNameValues.reverse[name],
//       };
// }
//
// enum OtherChargeName {
//   DELIVERY_CHARGES,
//   MAINTENANCE_CHARGES,
//   POLYTHENE_CHARGES_SMALL,
//   POLYTHEN_CHARGES_BIG
// }
//
// final otherChargeNameValues = EnumValues({
//   "Delivery Charges": 'Delivery Charges',
//   "Maintenance Charges": "Maintenance Charges",
//   "Polythene Charges Small ": "Polythene Charges Small ",
//   "Polythen Charges Big": "Polythen Charges Big"
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

import 'dart:convert';

UserDailyNeedDetails userDailyNeedDetailsFromJson(String str) =>
    UserDailyNeedDetails.fromJson(json.decode(str));

String userDailyNeedDetailsToJson(UserDailyNeedDetails data) =>
    json.encode(data.toJson());

class UserDailyNeedDetails {
  String message;
  bool success;
  List<DialNeedList> dialNeedList;

  UserDailyNeedDetails({
    required this.message,
    required this.success,
    required this.dialNeedList,
  });

  factory UserDailyNeedDetails.fromJson(Map<String, dynamic> json) =>
      UserDailyNeedDetails(
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
  String orderId;
  String name;
  DateTime createdAt;
  String contact;
  String email;
  String address;
  String status;
  List<OtherCharge> otherCharges;
  List<Map<String, String?>> productdetails;

  DialNeedList({
    required this.customerId,
    required this.orderId,
    required this.name,
    required this.createdAt,
    required this.contact,
    required this.email,
    required this.address,
    required this.status,
    required this.otherCharges,
    required this.productdetails,
  });

  int getProductCount() {
    return productdetails.length;
  }

  factory DialNeedList.fromJson(Map<String, dynamic> json) => DialNeedList(
        customerId: json["customer_id"],
        orderId: json["order_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        contact: json["contact"],
        email: json["email"],
        address: json["address"],
        status: json["status"],
        otherCharges: List<OtherCharge>.from(
            json["other_charges"].map((x) => OtherCharge.fromJson(x))),
        productdetails: List<Map<String, String?>>.from(json["productdetails"]
            .map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "order_id": orderId,
        "name": name,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "contact": contact,
        "email": email,
        "address": address,
        "status": status,
        "other_charges":
            List<dynamic>.from(otherCharges.map((x) => x.toJson())),
        "productdetails": List<dynamic>.from(productdetails.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}

class OtherCharge {
  String id;
  String otherChargesId;
  String customerId;
  String orderId;
  String amount;
  DateTime createdAt;
  String name;

  OtherCharge({
    required this.id,
    required this.otherChargesId,
    required this.customerId,
    required this.orderId,
    required this.amount,
    required this.createdAt,
    required this.name,
  });

  factory OtherCharge.fromJson(Map<String, dynamic> json) => OtherCharge(
        id: json["id"],
        otherChargesId: json["other_charges_id"],
        customerId: json["customer_id"],
        orderId: json["order_id"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "other_charges_id": otherChargesId,
        "customer_id": customerId,
        "order_id": orderId,
        "amount": amount,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "name": name,
      };
}
