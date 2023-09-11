// import 'dart:developer';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationHelper {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> initializeNotification() async {
//     AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings("@mipmap/ic_launcher");
//     DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestCriticalPermission: true,
//       requestSoundPermission: true,
//     );
//     InitializationSettings initializationSettings =
//         InitializationSettings(android: androidSettings, iOS: iosSettings);
//     bool? initialized =
//         await notificationsPlugin.initialize(initializationSettings);
//
//     log("Notification: ${initialized}");
//   }
//
//   Future<void> showNotificationAlert({String? payload}) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id',
//       'Your Notification Channel',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await notificationsPlugin.show(
//       0, // Notification ID (unique for each notification)
//       'New Notification', // Notification title
//       'You have new notifications!', // Notification body
//       platformChannelSpecifics,
//       payload: payload, // Optional payload for notification tap
//     );
//   }
// }

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMPushNotificationService {
  FCMPushNotificationService._();

  factory FCMPushNotificationService() => instance;
  static final FCMPushNotificationService instance =
      FCMPushNotificationService._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  int badgeCount = 0;
  String fcmToken = "";
  static BuildContext? get context => null;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true,
  );

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  init() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true);

    ///for android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be done later
    /// for ios
    // await enableIOSNotifications();
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: true,
      defaultPresentSound: true,
      onDidReceiveLocalNotification: (
        int? id,
        String? title,
        String? body,
        String? payload,
      ) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    ///on initialize()----------------------------------------------------------------------------
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          debugPrint('notification payload: ${jsonDecode(payload!)}');
        }
        // await Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
        // await Get.offNamedUntil(AppRoutes.notification, (route) => false);
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    ///onMessage.listen()-------------------------------------------------------
    ///2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      // ignore: unnecessary_null_comparison
      if (notification != null && android != null) {
        var bigTextStyleInformation =
            BigTextStyleInformation(notification.body!);
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: '@mipmap/ic_launcher',
              playSound: true,
              styleInformation: bigTextStyleInformation,
            ),
          ),
          payload: jsonEncode(message.data),
        );
        // Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
        // Get.offNamedUntil(AppRoutes.notification, (route) => false);
      }

    });

    ///onMessageOpenedApp.listen()-------------------------------------------------------
    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
      // Get.offNamedUntil(AppRoutes.notification, (route) => false);
    });

    ///get token method-------------------------------------------------------
    _firebaseMessaging.getToken().then((token) async {
      // ignore: unnecessary_this
      this.fcmToken = token!;
      // var isTokenSent = PrefData().isTokenSent();
      // if (!isTokenSent && fcmToken != "") {
      //   var response =
      //   await ApiRepository(apiClient: ApiClient()).sendFcmToken(fcmToken);
      //   if (response.status) {
      //     PrefData().setToken();
      //   }
    });

    ///instance.getInitialMessage()-------------------------------------------------------
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
        // Get.offNamedUntil(AppRoutes.notification, (route) => false);
      }
    });
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
}
