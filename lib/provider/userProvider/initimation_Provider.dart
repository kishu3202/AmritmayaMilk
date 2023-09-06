import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class IntimationProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void postPauseTheService(
      BuildContext context,
      String customerId,
      String fromDate,
      String toDate,
      String pauseTheService,
      String productId,
      String quantity) async {
    var map = <String, dynamic>{
      'customer_id': customerId,
      'from_date': fromDate,
      'to_date': toDate,
      'intimatechargepq': pauseTheService,
      'product_id': productId,
      'qnt': quantity,
    };
    setLoading(true);

    try {
      final response = await post(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/UserApiController/intimateToAdmin"),
        headers: {'X-API-KEY': 'amritmayamilk050512'},
        body: map,
      );
      final Map<String, dynamic>? res = json.decode(response.body);
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final bool? success = res?['Success'];
        final String message = res?['Message'] ?? "Unknown message";
        if (success == true) {
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Colors.green,
          );
          print("Successful");
          Navigator.pop(context);
          setLoading(false);
        } else {
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Colors.red,
          );
          setLoading(false);
          print("Failed");
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Internal Server Error.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.red,
        );
        setLoading(false);
        print("Failed");
      }
    } catch (e) {}
  }
}
