import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:amritmaya_milk/widget/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/productRate_data_model.dart';

class ProductRateProvider extends ChangeNotifier {
  List<ProductRateList>? post;
  bool loading = false;

  Future<Map<String, dynamic>> getProductRateList(
      productId, unitId, quantityId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rate = prefs.getString('rate') ?? '';
    Map<String, dynamic> responseMap = {
      'status': false,
      'msg': '',
    };
    try {
      final res = await http.get(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId"),
          headers: {
            "Content-Type": "application/json",
            "X-API-KEY": "amritmayamilk050512",
          });
      print(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/productrate?product_id=$productId&unit_id=$unitId&main_qnt=$quantityId");
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        responseMap['status'] = true;

        Strings.productRateIdList.clear();

        final response1 = response["productrateList"];
        response1.forEach((id) {
          Strings.productRateIdList.add(id["rate"]);
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
