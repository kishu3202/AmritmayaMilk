import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OutStandingAmountProvider extends ChangeNotifier {
  String? outstandingamount;
  String? totalpayamount;

  Future<void> fetchAmount(String? customerId) async {
    try {
      print("amount customerid: ${customerId}");
      final response = await http.get(
        Uri.parse(
            'https://webiipl.in/amritmayamilk/api/UserApiController/outstandinglist?customer_id=$customerId'),
        headers: {'X-API-KEY': 'amritmayamilk050512'},
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("amount response: ${responseData}");

        outstandingamount = responseData['outstandingamount'].toString();
        totalpayamount = responseData['totalpayamount'];

        notifyListeners();
        notifyListeners();
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching amount: $error');
      throw Exception('Failed to load amount');
    }
  }
}
