import 'package:amritmaya_milk/provider/dailyNeedProduct_Provider.dart';
import 'package:amritmaya_milk/screens/productDetails_screen.dart';
import 'package:amritmaya_milk/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/dailyNeedProduct_data_model.dart';

class FormScreen extends StatefulWidget {
  final String customerId;
  const FormScreen({required this.customerId, Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    super.initState();
    final dailyNeedProvider =
        Provider.of<DailyNeedProductProvider>(context, listen: false);
    dailyNeedProvider.getPostDailyNeedProduct(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    final dailyNeedProvider =
        Provider.of<DailyNeedProductProvider>(context, listen: false);
    final dailyNeedList = dailyNeedProvider.dialNeedList;
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
            return Consumer<DailyNeedProductProvider>(
              builder: (context, dailyNeedProvider, child) {
                final dailyNeedList = dailyNeedProvider.dialNeedList;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: dailyNeedList.length,
                    itemBuilder: (context, index) {
                      final DialNeedList dialNeed = dailyNeedList[index];
                      // final dialNeed = dailyNeedList[index];
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
                                SizedBox(
                                  height: 8.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Customer Name: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${dialNeed.name ?? "N/A"}',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Created Date: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${dialNeed.createdAt?.toString() ?? ""}',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Order ID: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${dialNeed.orderId ?? ""}',
                                        style: TextStyle(color: Colors.black87) ,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(
                                                      dialNeed: dialNeed,
                                                    )));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                      child: Text(
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

      // body: SizedBox(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: ListView.builder(
      //     shrinkWrap: true,
      //     physics: NeverScrollableScrollPhysics(),
      //     itemCount: dailyNeedList.length,
      //     itemBuilder: (context, index) {
      //       final dialNeed = dailyNeedList[index];
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Card(
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(10.0)),
      //           color: Colors.deepPurple.shade50,
      //           child: Column(
      //             children: [
      //               SizedBox(
      //                 height: 8.0,
      //               ),
      //               Text(dailyNeedProvider.dialNeedList[index].name ?? ""),
      //               SizedBox(
      //                 height: 5.0,
      //               ),
      //               Text(dailyNeedProvider.dialNeedList[index].createdAt
      //                       .toString() ??
      //                   ""),
      //               SizedBox(
      //                 height: 5.0,
      //               ),
      //               Text(
      //                 dailyNeedProvider.dialNeedList[index].orderId ?? "",
      //               ),
      //               SizedBox(
      //                 height: 5.0,
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      floatingActionButton: Container(
        height: 60,
        width: 220,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(
                  customerId: widget.customerId,
                ),
              ),
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: const Text(
            'Add Daily Need Products',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
