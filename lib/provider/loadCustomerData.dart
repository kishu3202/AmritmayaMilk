import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../screens/customer_list_screen.dart';

Future<Customer?> getSinglePostData() async {
  Customer? result;
  try {
    // var map = new Map<String, dynamic>();
    // map['name'] = name;
    // map['email'] = email;
    // map['contact'] = 'contact';
    // map['address'] = 'address';
    final response = await http.get(
      Uri.parse(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/customerlist"),
      headers: {'X-API-KEY': 'amritmayamilk050512'},
    );
    // Map<String, dynamic> res = json.decode(response.body);
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = Customer.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString() as num);
  }
  return result;
}
