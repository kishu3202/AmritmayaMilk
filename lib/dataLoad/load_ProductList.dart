import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../data/productList_data_model.dart';

Future<List<ProductList>> getProductList() async {
  List<ProductList> result = [];
  try {
    final response = await http.get(
      Uri.parse(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist"),
      headers: {'X-API-KEY': 'amritmayamilk050512'},
    );
    print(
        "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist");
    if (response.statusCode == 200) {
      final item = await json.decode(response.body);
      for (var product in item['productList']) {
        result.add(ProductList.fromJson(product));
      }
      print("product list is here ${result}");
    } else {
      print("Error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
