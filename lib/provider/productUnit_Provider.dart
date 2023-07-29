import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:amritmaya_milk/widget/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../data/productUnit_data_model.dart';

class ProductUnitProvider extends ChangeNotifier {
  List<ProductUnitList>? post;
  // List<ProductUnitList> productUnitList = [];
  bool loading = false;

  Future<Map<String, dynamic>> getProductUnitList(productId) async {
    Map<String, dynamic> responseMap = {
      'status': false,
      'msg': '',
    };
    try {
      final res = await http.get(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId"),
          headers: {
            "Content-Type": "application/json",
            "X-API-KEY": "amritmayamilk050512",
          });
      print(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productunit?product_id=$productId");
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        responseMap['status'] = true;

        Strings.productUnitIdList.clear();
        Strings.productUnitNameList.clear();

        final response1 = response["productunitList"];
        response1.forEach((id) {
          Strings.productUnitIdList.add(id["unit_id"]);
          Strings.productUnitNameList.add(id["name"]);
          print(Strings.productUnitNameList);
          print("****************************************");
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
