import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DailyNeedProductProvider extends ChangeNotifier {
  List<String> customerID = [];
  List<String> customerName = [];
  List<String> customerOrderID = [];
  List<String> customerCreatedDate = [];
  List<String> customerProductDetails = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  Future<void> fetchDailyNeedProduct(String customerId) async {
    try {
      final res = await http.get(
        Uri.parse(
            'http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedlist?customerId=$customerId'),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );
      print(
          'http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedlist?customerId=$customerId');
      final response = json.decode(res.body) as Map<String, dynamic>;
      print('API Response: $response');
      customerID.clear();
      customerName.clear();
      customerCreatedDate.clear();
      customerOrderID.clear();
      customerProductDetails.clear();

      if (response['Success'] == false) {
        return;
      }

      if (res.statusCode == 200) {
        final productDetails = response['dialNeedList'];
        if (productDetails != null && productDetails.isNotEmpty) {
          productDetails.forEach((customer) {
            customerID.add(customer["customer_id"]);
            customerName.add(customer["name"]);
            customerOrderID.add(customer["order_id"]);
            customerCreatedDate.add(customer["created_at"]);
            customerProductDetails.add(customer["productdetails"]);
          });
        } else {
          customerID = [];
          customerName = [];
          customerCreatedDate = [];
          customerOrderID = [];
          customerProductDetails = [];
        }
      } else {
        throw Exception('Failed to fetch daily need product data');
      }
      await Future.delayed(Duration.zero);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch daily need product data');
    }
  }
}
