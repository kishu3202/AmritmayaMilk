import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class ChangePasswordProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void changePassword(BuildContext context, String customerId,
      String oldPassword, String newPassword) async {
    var map = <String, dynamic>{
      'id': customerId,
      'old_password': oldPassword,
      'new_password': newPassword,
    };

    setLoading(true);

    try {
      final response = await post(
        Uri.parse(
            "http://webiipl.in/amritmayamilk/api/UserApiController/change_password"),
        headers: {'X-API-KEY': 'amritmayamilk050512'},
        body: map,
      );

      final Map<String, dynamic>? res = json.decode(response.body);

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final bool? success = res?['status'];
        final String message = res?['message'] ?? "Unknown message";

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
    } catch (e) {
      print("Error in change Password: ${e.toString()}");
    }
  }
}
