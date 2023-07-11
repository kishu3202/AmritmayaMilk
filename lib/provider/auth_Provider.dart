import 'package:flutter/material.dart';
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
      Response response = await post(
          Uri.parse(
              " https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/login"),
          body: {email: email, password: password});
      if (response.statusCode == 200) {
        print("Succssful");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
        setLoading(false);
      } else {
        setLoading(false);
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
