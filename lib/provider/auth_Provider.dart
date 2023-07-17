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
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   if (data['success'] == true) {
      //     showToast('Login Successfully');
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const DashboardScreen()),
      //     );
      //   } else {
      //     showToast('Wrong password');
      //   }
      // }
      if (res['Success'] == true) {
        print("Succssful");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
        setLoading(false);
      } else {
        setLoading(false);
        print("Login Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    timeInSecForIosWeb: 2,
  );
}
