import 'dart:developer';

import 'package:amritmaya_milk/provider/deliveryBoyProvider/auth_Provider.dart';
import 'package:amritmaya_milk/provider/deliveryBoyProvider/customerList_Provider.dart';
import 'package:amritmaya_milk/provider/deliveryBoyProvider/dailyNeedList_Provider.dart';
import 'package:amritmaya_milk/provider/deliveryBoyProvider/productList_Provider.dart';
import 'package:amritmaya_milk/provider/deliveryBoyProvider/user_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/bill_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/changePassword_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/dailyNeedDetails_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/initimation_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/notification_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/outstandingAmount_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/requestRaise_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/support_Provider.dart';
import 'package:amritmaya_milk/provider/userProvider/userProduct_Provider.dart';
import 'package:amritmaya_milk/screens/dashboard_screen.dart';
import 'package:amritmaya_milk/screens/login_screen.dart';
import 'package:amritmaya_milk/widget/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await FCMPushNotificationService().init();
  runApp(const AmritmayaMilk());
}

class AmritmayaMilk extends StatefulWidget {
  const AmritmayaMilk({super.key});

  @override
  State<AmritmayaMilk> createState() => _AmritmayaMilkState();
}

class _AmritmayaMilkState extends State<AmritmayaMilk> {
  var isLoggedIn = true;
  var isDeliveryBoy = false;
  String customerId = '';

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log("FCMToken $fcmToken");
    prefs.setString("token", fcmToken!);
  }

  void checkIsUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
    if (prefs.getString('email') == null) {
      setState(() {
        isLoggedIn = false;
      });
    } else {
      setState(() {
        isDeliveryBoy = prefs.getBool("isDeliveryBoy") ?? false;
      });
    }
  }

  final Future<String> _getCustomerId = Future.delayed(Duration.zero, () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var customerId = prefs.getString('id') ?? '';
    print('customer id for user: ${customerId}');
    return customerId;
  });

  @override
  void initState() {
    super.initState();
    checkIsUserLoggedIn();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => ProductListProvider()),
        ChangeNotifierProvider(create: (_) => DailyNeedProductProvider()),
        ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
        ChangeNotifierProvider(create: (_) => BillProvider()),
        ChangeNotifierProvider(create: (_) => DailyNeedDetailsProvider()),
        ChangeNotifierProvider(create: (_) => OutStandingAmountProvider()),
        ChangeNotifierProvider(create: (_) => SupportProvider()),
        ChangeNotifierProvider(create: (_) => UserProductProvider()),
        ChangeNotifierProvider(create: (_) => IntimationProvider()),
        ChangeNotifierProvider(create: (_) => RequestRaiseProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (isLoggedIn) {
              // User is logged in, show DashboardScreen
              return FutureBuilder<String?>(
                  future: _getCustomerId,
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? DashboardScreen(
                            isDeliveryBoy: isDeliveryBoy,
                            customerId: snapshot.data!,
                            userData: snapshot.data!,
                          )
                        : Container();
                  });
            } else {
              // User is not logged in, show LoginScreen
              return LoginScreen();
            }
          },
        ),
        // home: Material(
        //   child: MainTestScreen(),
        // ),
      ),
    );
  }
}
