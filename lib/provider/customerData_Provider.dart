import 'dart:convert';

import 'package:amritmaya_milk/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDataProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void getCustomerData(BuildContext context, String mobileNumber) async {
    setLoading(true);
    try {
      var map = new Map<String, dynamic>();
      map['contact'] = 'mobileNumber';
      map['token'] = 'testing';
      map['type'] = 'user';
      Response response = await get(
        Uri.parse(
            "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/customerdata?contact=$mobileNumber"),
        headers: {'X-API-KEY': 'amritmayamilk050512'},
      );
      Map<String, dynamic> res = json.decode(response.body);
      print(res['Success']);
      if (res['Success'] == true) {
        final customerResponse = res['CustomerDetails'];

        // Save the login data using shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', customerResponse['token']);
        prefs.setString('id', customerResponse['id']);
        prefs.setString('name', customerResponse['name']);
        prefs.setString('contact', customerResponse['contact']);
        prefs.setString('email', customerResponse['email']);
        prefs.setString('address', customerResponse['address']);

        Fluttertoast.showToast(
            msg: 'Customer Data fetch Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        print("Succssful");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FormScreen()),
        );
        setLoading(false);
      } else {
        var responseData = response.body;
        if (responseData.contains('Invalid credentials.')) {
          Fluttertoast.showToast(
              msg: 'Invalid credentials',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
        setLoading(false);
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
