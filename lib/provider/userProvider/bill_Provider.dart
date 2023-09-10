import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../data/userDataModel/userBills_data _model.dart';

class BillProvider extends ChangeNotifier {
  String fromDate = "";
  String toDate = "";
  List<Map<String, String?>> monthlyBills = [];
  int? totalAmount = 0;

  Future<void> fetchBills(
      String fromDate, String toDate, String customerId) async {
    final url = Uri.parse(
        'https://webiipl.in/amritmayamilk/api/UserApiController/monthlyBill?from_date=$fromDate&to_date=$toDate&customer_id=$customerId');
    final headers = {
      'X-API-KEY': 'amritmayamilk050512',
    };
    try {
      final response = await http.get(url, headers: headers);
      print("date:${fromDate}    ${toDate}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData != null) {
          final userBill = UserBill.fromJson(jsonData);

          if (userBill != null) {
            fromDate = userBill.monthlyBill.isNotEmpty
                ? userBill.monthlyBill[0]["from_date"] ?? ""
                : "";
            toDate = userBill.monthlyBill.isNotEmpty
                ? userBill.monthlyBill[0]["to_date"] ?? ""
                : "";
            totalAmount = userBill.totalAmount;
            monthlyBills = userBill.monthlyBill;

            notifyListeners();
          }
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print("Error fetching in bill: ${error}");
    }
  }
}
