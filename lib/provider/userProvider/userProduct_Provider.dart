import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserProductProvider extends ChangeNotifier {
  List<String> productIdList = [];
  List<String> productNameList = [];
  String selectedProduct = '';

  Future<void> fetchProduct() async {
    try {
      final res = await http.get(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist"),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        productIdList.clear();
        productNameList.clear();

        final productList = response["productList"];
        productList.forEach((product) {
          productIdList.add(product["id"]);
          productNameList.add(product["name"]);

          print("product: ${productIdList}");
          print("product: ${productNameList}");
        });

        notifyListeners();
      } else {
        throw Exception('Failed to fetch product names');
      }
    } catch (e) {
      throw Exception('Failed to fetch product names');
    }
  }
}
