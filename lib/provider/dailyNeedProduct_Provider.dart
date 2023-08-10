import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/dailyNeedProduct_data_model.dart';

class DailyNeedProductProvider extends ChangeNotifier {
  List<DialNeedList> dialNeedList = [];
  bool loading = false;

  Future<List<DialNeedList>> getPostDailyNeedProduct(String customerId) async {
    loading = true;
    dialNeedList = await getDailyNeedProductData(customerId);
    loading = false;
    notifyListeners();
    return dialNeedList;
  }

  Future<List<DialNeedList>> getDailyNeedProductData(String customerId) async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedlist?customer_id=$customerId"),
        headers: {'X-API-KEY': 'amritmayamilk050512'},
      );
      print("API Response Status Code: ${response.statusCode}");
      print("API Response Body: ${response.body}");
      print(
          "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedlist?customer_id=$customerId");
      if (response.statusCode == 200) {
        final item = await json.decode(response.body);
        dialNeedList.clear(); // Clearing only when data is available

        for (var product in item['dialNeedList']) {
          dialNeedList.add(DialNeedList.fromJson(product));
        }
        print("product in daily need product ${dialNeedList}");

        // Save the data
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

// class DailyNeedProductProvider extends ChangeNotifier {
//   List<DialNeedList> dialNeedList = [];
//   bool loading = false;
//
//   Future<List<DialNeedList>> getPostDailyNeedProduct(String customerId) async {
//     loading = true;
//     dialNeedList = await getDailyNeedProductData(customerId);
//     loading = false;
//     notifyListeners();
//     List<DialNeedList> dataList = await getDailyNeedProductData(customerId);
//     return dataList;
//   }
//
//   Future<List<DialNeedList>> getDailyNeedProductData(String customerId) async {
//     List<DialNeedList> dialNeedList = [];
//     try {
//       final response = await http.get(
//         Uri.parse(
//             "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedlist?customer_id=$customerId"),
//         headers: {'X-API-KEY': 'amritmayamilk050512'},
//       );
//       print("API Response Status Code: ${response.statusCode}");
//       print("API Response Body: ${response.body}");
//       print(
//           "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedlist?customer_id=$customerId");
//       if (response.statusCode == 200) {
//         dialNeedList.clear();
//
//         final item = await json.decode(response.body);
//         for (var product in item['dialNeedList']) {
//           dialNeedList.add(DialNeedList.fromJson(product));
//         }
//         print("product in daily need product ${dialNeedList}");
//
//         // save the data
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         final encodedDataList =
//             dialNeedList.map((item) => item.toJson()).toList();
//         await prefs.setString('dialNeedList', json.encode(encodedDataList));
//         final savedData = prefs.getString('dialNeedList');
//         print("Saved DialNeedList from Shared Preferences: $savedData");
//       } else {
//         print(
//             "Error: API request failed with status code ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//     return dialNeedList;
//   }
// }
