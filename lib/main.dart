import 'package:amritmaya_milk/screens/login_screen.dart';
import 'package:amritmaya_milk/screens/registration_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AmritmayaMilk());
}

class AmritmayaMilk extends StatelessWidget {
  const AmritmayaMilk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginScreen(),
        'register': (context) => const RegistrationScreen(),
      },
    );
  }
}
