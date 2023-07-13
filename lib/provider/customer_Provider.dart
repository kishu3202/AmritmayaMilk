import 'package:amritmaya_milk/provider/loadCustomerData.dart';
import 'package:amritmaya_milk/screens/customer_list_screen.dart';
import 'package:flutter/widgets.dart';

class CustomerProvider extends ChangeNotifier {
  Customer? post;
  bool loading = false;

  getPostData() async {
    loading = true;
    post = (await getSinglePostData())!;
    loading = false;

    notifyListeners();
  }
}

// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// import '../screens/login_screen.dart';
//
// class CustomerProvider extends ChangeNotifier {
//   bool _loading = false;
//   bool get loading => _loading;
//
//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }
//
//   void login(BuildContext context, String email, String password, String name,
//       String phone) async {
//     setLoading(true);
//     try {
//       var map = new Map<String, dynamic>();
//       map['name'] = name;
//       map['contact'] = phone;
//       map['email'] = 'email';
//       map['address'] = 'address';
//       map['password'] = 'password';
//       Response response = await post(
//           Uri.parse(
//               "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/login"),
//           headers: {'X-API-KEY': 'amritmayamilk050512'},
//           body: map);
//       Map<String, dynamic> res = json.decode(response.body);
//       print(res['Success']);
//       if (res['Success'] == true) {
//         print("Succssful");
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//         );
//         setLoading(false);
//       } else {
//         setLoading(false);
//         print("Failed");
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
