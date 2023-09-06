import 'package:flutter/material.dart';

class MyQRScreen extends StatefulWidget {
  const MyQRScreen({super.key});

  @override
  State<MyQRScreen> createState() => _MyQRScreenState();
}

class _MyQRScreenState extends State<MyQRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My QR"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/media/qrcode/4e616d653a4d616e6a697269204d616e652c2070686f6e653a393636353530343633392c20416464726573733a50756e65.png",
              height: 300,
              width: 300,
            )
          ],
        ),
      ),
    );
  }
}
