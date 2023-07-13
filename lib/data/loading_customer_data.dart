import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'data_model.dart';

Future<DataModel?> getData() async {
  DataModel? result;
  try {
    final response = await http.get(
      Uri.parse(
          "https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/customerlist"),
      headers: {'X-API-KEY': 'amritmayamilk050512'},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DataModel.fromJson(item);
    } else {
      print("Error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
