import 'dart:convert';

import 'package:amritmaya_milk/data/customerlist_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDataProvider extends ChangeNotifier {
  DataModel? _customerData;
  DataModel? get customerData => _customerData;

  Future<void> fetchCustomerData(String mobileNumber) async {
    final url =
        "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/customerdata?contact=$mobileNumber";
    final headers = {'X-API-KEY': 'amritmayamilk050512'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _customerData = DataModel(
            id: data['id'],
            name: data['name'],
            email: data['email'],
            contact: data['contact'],
            address: data['address']);
        saveCustomerId(data['id']);
        notifyListeners();
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed.');
    }
  }

  Future<void> saveCustomerId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', id);
  }

  Future<int?> getSavedCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }
}
