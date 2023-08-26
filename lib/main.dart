import 'package:amritmaya_milk/provider/auth_Provider.dart';
import 'package:amritmaya_milk/provider/customerList_Provider.dart';
import 'package:amritmaya_milk/provider/dailyNeedList_Provider.dart';
import 'package:amritmaya_milk/provider/productList_Provider.dart';
import 'package:amritmaya_milk/provider/user_Provider.dart';
import 'package:amritmaya_milk/screens/dashboard_screen.dart';
import 'package:amritmaya_milk/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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

  @override
  void initState() {
    super.initState();
    checkIsUserLoggedIn();
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: isLoggedIn ? const DashboardScreen() : const LoginScreen(),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (isLoggedIn) {
              // User is logged in, show DashboardScreen
              return DashboardScreen(isDeliveryBoy: isDeliveryBoy);
            } else {
              // User is not logged in, show LoginScreen
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
