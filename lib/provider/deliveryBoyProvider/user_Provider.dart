import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class UserProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void register(BuildContext context, String name, String phone, String email,
      String address, String password) async {
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['contact'] = phone;
    map['address'] = address;
    setLoading(true);
    try {
      Response response = await post(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/UserApiController/registration"),
          headers: {'X-API-KEY': 'amritmayamilk050512'},
          body: map);

      Map<String, dynamic> res = json.decode(response.body);
      if (response.statusCode == 200) {
        if (res['Success'] == true) {
          Fluttertoast.showToast(
              msg: 'User Registration successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              backgroundColor: Colors.green);
          print("Succssful");
          Navigator.pop(context);

          setLoading(false);
        } else {
          Fluttertoast.showToast(
            msg: res['Message'],
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
      print(e.toString());
    }
  }
}
