import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:amritmaya_milk/widget/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../data/productQuantity_data_model.dart';

class ProductQuantityProvider extends ChangeNotifier {
  List<ProductQuantityList>? post;
  bool loading = false;

  Future<Map<String, dynamic>> getProductQuantityList(productId, unitId) async {
    Map<String, dynamic> responseMap = {
      'status': false,
      'msg': '',
    };
    try {
      final res = await http.get(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId"),
          headers: {
            "Content-Type": "application/json",
            "X-API-KEY": "amritmayamilk050512",
          });
      print(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productqnt?product_id=$productId&unit_id=$unitId");
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        responseMap['status'] = true;

        Strings.productQuantityIdList.clear();

        final response1 = response["productqntList"];
        response1.forEach((id) {
          Strings.productQuantityIdList.add(id["qnt"]);
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
