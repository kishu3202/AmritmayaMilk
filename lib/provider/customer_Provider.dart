import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CustomerProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void customer(BuildContext context, String name, String email,
      String password, String phone, String address) async {
    setLoading(true);
    try {
      Response response = await post(
          Uri.parse(
              " https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/customerlist"),
          headers: {
            'X-API-KEY': 'amritmayamilk050512'
          },
          body: {
            name: name,
            phone: phone,
            address: address,
            email: email,
            password: password
          });
      if (response.statusCode == 200) {
        print("Succssful");
        Navigator.pop(context);

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
