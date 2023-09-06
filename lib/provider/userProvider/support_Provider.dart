import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SupportProvider extends ChangeNotifier {
  String? email;
  String? disclaimer;

  Future<void> fetchSupportData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://webiipl.in/amritmayamilk/api/UserApiController/supports'),
        headers: {'X-API-KEY': 'amritmayamilk050512'},
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("support response: ${responseData}");

        // Check if 'supportList' is present and not empty
        if (responseData['supportList'] != null &&
            responseData['supportList'].isNotEmpty) {
          // Assuming you want to access the first item in the 'supportList'
          final firstSupport = responseData['supportList'][0];
          email = firstSupport['email'];
          disclaimer = firstSupport['disclaimer'];
          notifyListeners();
        } else {
          print('No support data found.');
        }
      } else {
        print(
            'Failed to fetch supportData. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching support: $error');
    }
  }
}
