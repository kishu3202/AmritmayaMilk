import 'package:flutter/material.dart';

class IntimationScreen extends StatefulWidget {
  const IntimationScreen({super.key});

  @override
  State<IntimationScreen> createState() => _IntimationScreenState();
}

class _IntimationScreenState extends State<IntimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intimation"),
        centerTitle: true,
      ),
    );
  }
}
