class CustomerData {
  late String message;
  late bool success;
  List<CustomerList>? customerList;

  var data;

  CustomerData(
      {required this.message, required this.success, this.customerList});

  CustomerData.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['customerList'] != null) {
      customerList = <CustomerList>[];
      json['customerList'].forEach((v) {
        customerList!.add(new CustomerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = message;
    data['Success'] = success;
    if (customerList != null) {
      data['customerList'] = customerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerList {
  late String id;
  late String name;
  late String contact;
  late String email;
  late String address;
  late String barcode;
  late String password;
  late String status;
  late String type;
  late String token;
  late String termCondition;
  late String createdAt;
  late String updateAt;

  CustomerList(
      {required this.id,
      required this.name,
      required this.contact,
      required this.email,
      required this.address,
      required this.barcode,
      required this.password,
      required this.status,
      required this.type,
      required this.token,
      required this.termCondition,
      required this.createdAt,
      required this.updateAt});

  CustomerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    email = json['email'];
    address = json['address'];
    barcode = json['barcode'];
    password = json['password'];
    status = json['status'];
    type = json['type'];
    token = json['token'];
    termCondition = json['term_condition'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['contact'] = contact;
    data['email'] = email;
    data['address'] = address;
    data['barcode'] = barcode;
    data['password'] = password;
    data['status'] = status;
    data['type'] = type;
    data['token'] = token;
    data['term_condition'] = termCondition;
    data['created_at'] = createdAt;
    data['update_at'] = updateAt;
    return data;
  }
}
