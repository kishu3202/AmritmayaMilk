import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'data_model.dart';

Future<List<DataModel>> getData() async {
  List<DataModel> result = [];
  try {
    final response = await http.get(
      Uri.parse(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/customerlist"),
      headers: {'X-API-KEY': 'amritmayamilk050512'},
    );
    if (response.statusCode == 200) {
      final item = await json.decode(response.body);
      for (var customer in item['customerList']) {
        result.add(DataModel.fromJson(customer));
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
