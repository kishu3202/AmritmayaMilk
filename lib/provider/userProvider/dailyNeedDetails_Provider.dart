import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/userDataModel/user_DailyNeedDetails_data_model.dart';

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class DailyNeedDetailsProvider extends ChangeNotifier {
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
      final response = await http.get(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/UserApiController/dailyNeedlist?customer_id=$customerId"),
        headers: {'X-API-KEY': 'amritmayamilk050512'},
      );
      if (response.statusCode == 200) {
        final item = await json.decode(response.body);
        dialNeedList.clear();
        for (var product in item['dialNeedList']) {
          // print(" user Product: $product");
          dialNeedList.add(DialNeedList.fromJson(product));
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        final encodedDataList =
            dialNeedList.map((item) => item.toJson()).toList();
        await prefs.setString('dialNeedList', json.encode(encodedDataList));
        final savedData = prefs.getString('dialNeedList');
      } else {
        print(
            "Error: API request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return dialNeedList;
  }

  Future<void> fetchSavedDialNeedList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final savedData = prefs.getString('dialNeedList');
      if (savedData != null) {
        final List<dynamic> decodedData = json.decode(savedData);
        dialNeedList.clear();
        for (var product in decodedData) {
          dialNeedList.add(DialNeedList.fromJson(product));
          // print('user daily need list saved data: ${savedData}');
        }
        notifyListeners();
      } else {
        print("No saved data found in SharedPreferences.");
      }
    } catch (e) {
      print("Error fetching saved data from SharedPreferences: $e");
    }
  }

  Future<String?> fetchSavedOrderId(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('dialNeedList');
    if (savedData != null) {
      final List<dynamic> decodedData = json.decode(savedData);
      if (index >= 0 && index < decodedData.length) {
        final String orderId = decodedData[index]['order_id'];
        return orderId;
      }
    }
    return null; // Return null if the orderId couldn't be fetched
  }
}
