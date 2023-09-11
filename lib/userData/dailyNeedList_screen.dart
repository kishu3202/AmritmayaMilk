import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/userDataModel/user_DailyNeedDetails_data_model.dart';
import '../provider/userProvider/dailyNeedDetails_Provider.dart';
import '../provider/userProvider/requestRaise_Provider.dart';
import '../provider/userProvider/userProduct_Provider.dart';
import 'dailyNeedDetails_screen.dart';

class DailyNeedListScreen extends StatefulWidget {
  final String customerId;
  const DailyNeedListScreen({super.key, required this.customerId});

  @override
  State<DailyNeedListScreen> createState() => _DailyNeedListScreenState();
}

class _DailyNeedListScreenState extends State<DailyNeedListScreen> {
  TextEditingController requestRaiseController = TextEditingController();
  late String request;
  String? selectedProductId;

  @override
  void initState() {
    super.initState();
    getProductData();

    final dailyNeedProvider =
        Provider.of<DailyNeedDetailsProvider>(context, listen: false);
    dailyNeedProvider.getPostDailyNeedProduct(widget.customerId);
    print("Init State: Fetching data for customer ID: ${widget.customerId}");

    dailyNeedProvider.fetchSavedDialNeedList();
    fetchAndPrintOrderId(dailyNeedProvider, 0);
  }

  void fetchAndPrintOrderId(
      DailyNeedDetailsProvider dailyNeedProvider, int index) async {
    String? orderId = await dailyNeedProvider.fetchSavedOrderId(index);
    if (orderId != null) {
      // Use the orderId here
      print('Order ID for index $index: $orderId');
    } else {
      // Handle the case where orderId couldn't be fetched
      print('Failed to fetch orderId for index $index.');
    }
  }

  void getProductData() async {
    final productProvider =
        Provider.of<UserProductProvider>(context, listen: false);
    try {
      await productProvider.fetchProduct();
      final id = productProvider.productIdList;
      final name = productProvider.productNameList;
      print('Product Id: $id');
      print('Product Name: $name');
    } catch (error) {
      print('Error fetching amount: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Need List"),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
          future: Future.value(null),
          builder: (context, snapshot) {
            return Consumer<DailyNeedDetailsProvider>(
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
                                        text: 'Order Id: ',
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
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Date: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${DateFormat('yyyy-MM-dd').format(dialNeedList.createdAt)}',
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
                                        text: 'Product Count: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${dialNeedList.getProductCount()}',
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DailyNeedDetailsScreen(
                                                            dialNeed:
                                                                dialNeedList,
                                                          )));
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              final encodedDataList =
                                                  dailyNeedList
                                                      .map(
                                                          (item) => item.toJson())
                                                      .toList();
                                              await prefs.setString(
                                                  'dialNeedList',
                                                  json.encode(encodedDataList));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              primary: Colors.grey.shade50,
                                            ),
                                            child: const Text(
                                              "View",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16),
                                            )),
                                      ),
                                      VerticalDivider(
                                        width: 30, // Adjust the width of the vertical divider as needed
                                        color: Colors.grey, // Set the color of the vertical divider
                                      ),
                                      Expanded(
          //                               child: TextButton(
          //                                   child: Text('Request Raise'), onPressed: () async {
          //                                     // _showRequestRaisePopup(context);
          // final index = dailyNeedList
          //     .indexOf(dialNeedList);
          // if (index >= 0) {
          //   final orderId =
          //       await dailyNeedProvider
          //           .fetchSavedOrderId(index);
          //   _showRequestRaisePopup(
          //       context, orderId);
          // } else {
          //   print(
          //       'Failed to find index for the selected dialNeedList.');
          // }}),
                                        child: TextButton(
                                            onPressed: () async {
                                              // _showRequestRaisePopup(context);
                                              final index = dailyNeedList
                                                  .indexOf(dialNeedList);
                                              if (index >= 0) {
                                                final orderId =
                                                    await dailyNeedProvider
                                                        .fetchSavedOrderId(index);
                                                _showRequestRaisePopup(
                                                    context, orderId);
                                              } else {
                                                print(
                                                    'Failed to find index for the selected dialNeedList.');
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              primary: Colors.grey.shade50,
                                            ),
                                            child: const Text(
                                              "Request Raise",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16),
                                            )),
                                      ),
                                    ]),
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
    );
  }

  Future<Future<bool?>> _showRequestRaisePopup(context, String? orderId) async {
    final _requestRaiseKey = GlobalKey<FormState>();
    final productProvider =
        Provider.of<UserProductProvider>(context, listen: false);
    final requestRaiseProvider =
        Provider.of<RequestRaiseProvider>(context, listen: false);

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple.shade50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Request Raise'),
          content: Container(
            width: 300,
            height: 250,
            child: Form(
              key: _requestRaiseKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    hint: Text('Select a product'),
                    value: selectedProductId,
                    items: productProvider.productIdList.map((productId) {
                      final index =
                          productProvider.productIdList.indexOf(productId);
                      return DropdownMenuItem<String>(
                        value: productId,
                        child: Text(productProvider.productNameList[index]),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProductId = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a product';
                      }
                      return null;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.blue,
                    ),
                    dropdownColor: Colors.deepPurple.shade50,
                    decoration: InputDecoration(
                      labelText: "Product Name",
                      prefixIcon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        request = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    controller: requestRaiseController,
                    decoration: InputDecoration(
                      hintText: 'Raise Dispute',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a request to raise';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final product = selectedProductId;
                          final date = requestRaiseController.text;
                          if (product!.isNotEmpty &&
                              date.isNotEmpty &&
                              orderId != null) {
                            print('Submitted Data:');
                            print('Customer ID: ${widget.customerId}');
                            print('Product: $product');
                            print('Date: $date');
                            print('Order ID: $orderId');
                            requestRaiseProvider.postRequest(context,
                                widget.customerId, product, date, orderId);
                          } else if (_requestRaiseKey.currentState!
                              .validate()) {
                            Navigator.pop(context);
                            print('false');
                          }
                        });
                      },
                      child: Text("Submit"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
