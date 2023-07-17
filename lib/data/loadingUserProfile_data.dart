import 'dart:convert';
import 'dart:developer';

import 'package:amritmaya_milk/data/userProfileData_model.dart';
import 'package:http/http.dart' as http;

Future<List<UserProfileDataModel>> getUserProfileData() async {
  List<UserProfileDataModel> result = [];
  try {
    final response = await http.get(
      Uri.parse(
          "https://webiipl.in/amritmayamilk/api/UserApiController/profile_update"),
      headers: {'X-API-KEY': 'amritmayamilk050512'},
    );
    if (response.statusCode == 200) {
      final item = await json.decode(response.body);
      for (var customer in item['customerList']) {
        result.add(UserProfileDataModel.fromJson(customer));
      }
      print("customer list is here ${result}");
    } else {
      print("Error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
