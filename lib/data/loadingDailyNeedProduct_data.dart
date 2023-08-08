import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dailyNeedProduct_data_model.dart';

Future<List<DialNeedList>> getDailyNeedProductData(String customerId) async {
  List<DialNeedList> dialNeedList = [];
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
      for (var product in item['dialNeedList']) {
        dialNeedList.add(DialNeedList.fromJson(product));
      }
      print("product in daily need product ${dialNeedList}");
    } else {
      print(
          "Error: API request failed with status code ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
  return dialNeedList;
}
