import 'package:flutter/material.dart';

class DailyNeedListScreen extends StatefulWidget {
  const DailyNeedListScreen({super.key});

  @override
  State<DailyNeedListScreen> createState() => _DailyNeedListScreenState();
}

class _DailyNeedListScreenState extends State<DailyNeedListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Need List"),
        centerTitle: true,
      ),
    );
  }
}
