import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/deliverBoy_data_model/dailyNeedList_data_model.dart';

class DailyNeedProductProvider extends ChangeNotifier {
  List<DialNeedList> dialNeedList = [];
  bool loading = false;

  Future<List<DialNeedList>> getPostDailyNeedProduct(String customerId) async {
    loading = true;
    dialNeedList = await getDailyNeedProductData(customerId);
    loading = true;
    notifyListeners();
    return dialNeedList;
  }

  Future<List<DialNeedList>> getDailyNeedProductData(String customerId) async {
    try {
      print("Debug 1: Fetching data for customer ID: $customerId");
      final response = await http.get(
        Uri.parse(
            "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedlist?customer_id=$customerId"),
        headers: {'X-API-KEY': 'amritmayamilk050512'},
      );
      if (response.statusCode == 200) {
        final item = await json.decode(response.body);
        dialNeedList.clear();
        for (var product in item['dialNeedList']) {
          print("Product: $product");
          dialNeedList.add(DialNeedList.fromJson(product));
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        final encodedDataList =
            dialNeedList.map((item) => item.toJson()).toList();
        await prefs.setString('dialNeedList', json.encode(encodedDataList));
        final savedData = prefs.getString('dialNeedList');

        print("Saved DialNeedList from Shared Preferences: $savedData");
      } else {
        print(
            "Error: API request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return dialNeedList;
  }
}
