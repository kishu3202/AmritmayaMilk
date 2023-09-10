import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  List<String> notificationIdList = [];
  List<String> notificationTitleList = [];
  List<String> notificationDescriptionList = [];
  List<String> notificationStatusList = [];

  // Future<void> fetchNotification(String customerId) async {
  //   try {
  //     final res = await http.get(
  //       Uri.parse(
  //           "https://webiipl.in/amritmayamilk/api/UserApiController/notification_list/$customerId"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "X-API-KEY": "amritmayamilk050512",
  //       },
  //     );
  //     final response = json.decode(res.body) as Map<String, dynamic>;
  //     if (res.statusCode == 200) {
  //       notificationIdList.clear();
  //       notificationTitleList.clear();
  //       notificationDescriptionList.clear();
  //       notificationStatusList.clear();
  //
  //       final notifications = response["notification_list"];
  //       notifications.forEach((notification) async {
  //         notificationIdList.add(notification["id"]);
  //         notificationTitleList.add(notification["title"]);
  //         notificationDescriptionList.add(notification["description"]);
  //         notificationStatusList.add(notification["status"]);
  //       });
  //
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to fetch product names');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to fetch product names');
  //   }
  // }

  Future<void> fetchNotification(String customerId) async {
    try {
      final res = await http.get(
        Uri.parse(
            "https://webiipl.in/amritmayamilk/api/UserApiController/notification_list/$customerId"),
        headers: {
          "Content-Type": "application/json",
          "X-API-KEY": "amritmayamilk050512",
        },
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        notificationIdList.clear();
        notificationTitleList.clear();
        notificationDescriptionList.clear();
        notificationStatusList.clear();

        final notifications = response["notification_list"];
        final sharedPreferences = await SharedPreferences.getInstance();

        notifications.forEach((notification) {
          final notificationId = notification["id"];
          final notificationTitle = notification["title"];
          final notificationDescription = notification["description"];
          final notificationStatus = notification["status"];

          notificationIdList.add(notificationId);
          notificationTitleList.add(notificationTitle);
          notificationDescriptionList.add(notificationDescription);
          notificationStatusList.add(notificationStatus);

          /// Save the notification ID to SharedPreferences with a unique key
          // sharedPreferences.setString("notification_$notificationId", "read");
        });

        notifyListeners();
      } else {
        throw Exception('Failed to fetch product names');
      }
    } catch (e) {
      throw Exception('Failed to fetch product names');
    }
  }

  void markNotificationAsRead(String notificationId) async {
    final apiUrl =
        'https://webiipl.in/amritmayamilk/api/UserApiController/readnotification/$notificationId';
    final headers = {
      "Content-Type": "application/json",
      "X-API-KEY": "amritmayamilk050512",
    };
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );
      if (response.statusCode == 200) {
      } else {
        print(
            'Failed to mark notification as read. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error marking notification as read: $error');
    }
  }
}
