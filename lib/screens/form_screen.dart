import 'dart:convert';

import 'package:amritmaya_milk/provider/deliveryBoyProvider/dailyNeedList_Provider.dart';
import 'package:amritmaya_milk/screens/productDetails_screen.dart';
import 'package:amritmaya_milk/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/deliverBoy_data_model/dailyNeedList_data_model.dart';

class FormScreen extends StatefulWidget {
  final String customerId;

  const FormScreen({required this.customerId, Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Map<String, dynamic>? submittedData;
  @override
  void initState() {
    super.initState();
    final dailyNeedProvider =
        Provider.of<DailyNeedProductProvider>(context, listen: false);
    dailyNeedProvider.getPostDailyNeedProduct(widget.customerId);
    print("Init State: Fetching data for customer ID: ${widget.customerId}");
    _loadSubmittedData();
  }

  Future<void> _loadSubmittedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('submittedData');
    if (storedData != null) {
      setState(() {
        submittedData = json.decode(storedData);
        // print('Loaded submitted data from shared preferences: $submittedData');
      });
    }
  }

  void reloadPreviousScreen() {
    final dailyNeedProvider =
        Provider.of<DailyNeedProductProvider>(context, listen: false);
    dailyNeedProvider.getPostDailyNeedProduct(widget.customerId);
    print(
        "Reloading previous screen data for customer ID: ${widget.customerId}");
  }

  @override
  Widget build(BuildContext context) {
    final dailyNeedProvider =
        Provider.of<DailyNeedProductProvider>(context, listen: false);
    final dailyNeedList = dailyNeedProvider.dialNeedList;
    final loading = dailyNeedProvider.loading;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Need Product List'),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
          future: Future.value(null),
          // future: Provider.of<DailyNeedProductProvider>(context)
          //     .getPostDailyNeedProduct(widget.customerId),
          builder: (context, snapshot) {
            print("FutureBuilder - DailyNeedProductProvider loading: $loading");
            return Consumer<DailyNeedProductProvider>(
              builder: (context, dailyNeedProvider, _) {
                final dailyNeedList = dailyNeedProvider.dialNeedList;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: dailyNeedList.length,
                    itemBuilder: (context, index) {
                      final DialNeedList dialNeedList = dailyNeedList[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.deepPurple.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 8.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Customer Name: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${dialNeedList.name ?? "N/A"}',
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Created Date: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${DateFormat('yyyy-MM-dd').format(dialNeedList.createdAt)}',
                                        // text: '${dialNeedList.createdAt ?? ""}',
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Order ID: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${dialNeedList.orderId ?? ""}',
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(
                                                      dialNeed: dialNeedList,
                                                    )));
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        final encodedDataList = dailyNeedList
                                            .map((item) => item.toJson())
                                            .toList();
                                        await prefs.setString('dialNeedList',
                                            json.encode(encodedDataList));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                      child: const Text(
                                        "View",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }),
      floatingActionButton: Container(
        height: 60,
        width: 220,
        child: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(
                    customerId: widget.customerId,
                    onNavigateBack: reloadPreviousScreen),
              ),
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: const Text(
            'Add Daily Need Products',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
