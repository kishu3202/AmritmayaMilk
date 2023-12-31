import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/dashboard_screen.dart';
import '../../screens/login_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  int selectOption = 0;
  void setSelectOption(int option) {
    selectOption = option;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginUser(String customerId, String token) async {
    _isLoggedIn = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  void Userlogin(BuildContext context, String email, String password) async {
    setLoading(true);
    String customerId = '';
    String token = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? '';

    try {
      var map = new Map<String, dynamic>();
      map['email'] = email;
      map['password'] = password;
      map['token'] = token;
      map['type'] = 'user';
      Response response = await post(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/login"),
          headers: {'X-API-KEY': 'amritmayamilk050512'},
          body: map);
      Map<String, dynamic> res = json.decode(response.body);
      print(res['Success']);
      if (res['Success'] == true) {
        final loginResponse = res['UserDetails'];

        // Save the login data using shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('tokenFromApi', loginResponse['token']);
        prefs.setString('id', loginResponse['id']);
        prefs.setString('name', loginResponse['name']);
        prefs.setString('contact', loginResponse['contact']);
        prefs.setString('email', loginResponse['email']);
        prefs.setString('address', loginResponse['address']);
        prefs.setBool('isDeliveryBoy', false);

        print("token from : ${prefs.getString("tokenFromApi") ?? ""}");

        Fluttertoast.showToast(
            msg: 'User Login Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        print("Succssful");

        customerId = loginResponse['id'];
        token = loginResponse['token'];
        loginUser(customerId, token);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardScreen(
                  isDeliveryBoy: false,
                  customerId: customerId,
                  userData: loginResponse)),
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
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
        setLoading(false);
        print("Login Failed");
      }
    } catch (e) {
      print("login response:${e.toString()}");
    }
  }

  void DeliveryBoylogin(
      BuildContext context, String email, String password) async {
    setLoading(true);
    String customerId = '';
    String token = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? '';
    try {
      var map = new Map<String, dynamic>();
      map['email'] = email;
      map['password'] = password;
      map['token'] = token;
      map['type'] = 'delivery_boy';
      Response response = await post(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/login"),
          headers: {'X-API-KEY': 'amritmayamilk050512'},
          body: map);
      Map<String, dynamic> res = json.decode(response.body);
      print(res['Success']);
      if (res['Success'] == true) {
        final loginResponse = res['UserDetails'];

        // Save the login data using shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('tokenFromApi', loginResponse['token']);
        prefs.setString('id', loginResponse['id']);
        prefs.setString('name', loginResponse['name']);
        prefs.setString('contact', loginResponse['contact']);
        prefs.setString('email', loginResponse['email']);
        prefs.setString('address', loginResponse['address']);
        prefs.setBool('isDeliveryBoy', true);

        print("token from : ${prefs.getString("tokenFromApi") ?? ""}");

        Fluttertoast.showToast(
            msg: 'Delivery Boy Login Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        print("Succssful");

        token = loginResponse['token'];
        loginUser(customerId, token);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardScreen(
                    isDeliveryBoy: true,
                    customerId: customerId,
                    userData: loginResponse,
                  )),
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
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
        setLoading(false);
        print("Login Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    _isLoggedIn = false;
    notifyListeners();
  }
}
