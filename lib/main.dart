import 'package:amritmaya_milk/provider/auth_Provider.dart';
import 'package:amritmaya_milk/provider/customer_Provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: 'login',
        // routes: {
        //   'login': (context) => const LoginScreen(),
        //   'register': (context) => const RegistrationScreen(),
        // },
        home: isLoggedIn ? const DashboardScreen() : const LoginScreen(),
      ),
    );
  }
}
