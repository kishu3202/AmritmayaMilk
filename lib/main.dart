import 'package:amritmaya_milk/provider/auth_Provider.dart';
import 'package:amritmaya_milk/provider/customerList_Provider.dart';
import 'package:amritmaya_milk/provider/dailyNeedList_Provider.dart';
import 'package:amritmaya_milk/provider/productList_Provider.dart';
import 'package:amritmaya_milk/provider/user_Provider.dart';
import 'package:amritmaya_milk/screens/dashboard_screen.dart';
import 'package:amritmaya_milk/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AmritmayaMilk());
}

class AmritmayaMilk extends StatelessWidget {
  const AmritmayaMilk({super.key});

  final isLoggedIn = true;
  final isLoggedOut = true;

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
            if (authProvider.isLoggedIn) {
              // User is logged in, show DashboardScreen
              return const DashboardScreen();
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
