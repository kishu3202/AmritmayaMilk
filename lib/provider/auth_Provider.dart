import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../screens/dashboard_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) async {
    setLoading(true);
    try {
      var map = new Map<String, dynamic>();
      map['email'] = email;
      map['password'] = password;
      map['token'] = 'testing';
      map['type'] = 'user';
      Response response = await post(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/login"),
          headers: {'X-API-KEY': 'amritmayamilk050512'},
          body: map);
      Map<String, dynamic> res = json.decode(response.body);
      print(res['Success']);
      if (res['Success'] == true) {
        Fluttertoast.showToast(
            msg: 'User Login Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        print("Succssful");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
        setLoading(false);
      } else {
        var responseData = response.body;
        if (responseData.contains('Invalid credentials.')) {
          Fluttertoast.showToast(
              msg: 'Wrong password',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.white,
              textColor: Colors.red);
        }
        setLoading(false);
        print("Login Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
