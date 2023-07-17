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

  void register(BuildContext context, String name, String email,
      String password, String phone, String address) async {
    setLoading(true);
    try {
      Response response = await post(
          Uri.parse(
              "https://webiipl.in/amritmayamilk/api/UserApiController/registration"),
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
        Fluttertoast.showToast(
            msg: 'User Registration successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Colors.green);
        print("Succssful");
        Navigator.pop(context);

        setLoading(false);
      } else if (response.statusCode == 200) {
        var reponseData = response.body;
        if (reponseData.contains("This email is already exists.")) {
          Fluttertoast.showToast(
            msg: 'This email is already exists.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red,
          );
        }
        setLoading(false);
        print("Failed");
      } else {
        var reponseData = response.body;
        if (reponseData.contains("This contact is already exists.")) {
          Fluttertoast.showToast(
            msg: 'This contact is already exists.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red,
          );
        }
        setLoading(false);
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
