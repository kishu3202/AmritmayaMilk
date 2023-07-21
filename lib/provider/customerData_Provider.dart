import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerData {
  final int id;

  CustomerData({required this.id});
}

class CustomerDataProvider extends ChangeNotifier {
  CustomerData? _customerData;
  CustomerData? get customerData => _customerData;

  Future<void> getCustomerData(String mobileNumber) async {
    final url =
        "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/customerdata?contact=$mobileNumber";
    final headers = {'X-API-KEY': 'amritmayamilk050512'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _customerData = CustomerData(id: data['id']);
        notifyListeners();
        print('Customer Data fetch Successfully');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
