import 'dart:convert';
import 'dart:io';

import 'package:amritmaya_milk/data/productList_data_model.dart';
import 'package:amritmaya_milk/widget/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductListProvider extends ChangeNotifier {
  List<ProductList>? post;
  List<ProductList> productList = [];
  bool loading = false;

  Future<Map<String, dynamic>> getProductNameList() async {
    Map<String, dynamic> responseMap = {
      'status': false,
      'msg': '',
    };
    try {
      final res = await http.get(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist"),
          headers: {
            "Content-Type": "application/json",
            "X-API-KEY": "amritmayamilk050512",
          });
      print(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productlist");
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        responseMap['status'] = true;

        Strings.productIdList.clear();
        Strings.productNameList.clear();

        final response1 = response["productList"];
        response1.forEach((id) {
          Strings.productIdList.add(id["id"]);
          Strings.productNameList.add(id["name"]);
        });
        notifyListeners();
        return responseMap;
      } else {
        responseMap['status'] = false;
        responseMap['msg'] = 'Failed';
        return responseMap;
      }
    } on SocketException {
      responseMap['status'] = false;
      responseMap['msg'] = 'No Internet Connectivity';
      return responseMap;
    } catch (e) {
      print(e.toString());
      responseMap['status'] = false;
      responseMap['msg'] = 'Please try again later';
      return responseMap;
    }
  }
}
