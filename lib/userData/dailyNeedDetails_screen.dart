import 'package:flutter/material.dart';

import '../data/userDataModel/user_DailyNeedDetails_data_model.dart';

class DailyNeedDetailsScreen extends StatefulWidget {
  final DialNeedList dialNeed;
  const DailyNeedDetailsScreen({super.key, required this.dialNeed});

  @override
  State<DailyNeedDetailsScreen> createState() => _DailyNeedDetailsScreenState();
}

class _DailyNeedDetailsScreenState extends State<DailyNeedDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Need Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Customer Details:-",
                    style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.deepPurple.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Name: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.dialNeed.name.toString() ?? '',
                                style: const TextStyle(color: Colors.black87),
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
                                text: 'Contact: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.dialNeed.contact ?? '',
                                style: const TextStyle(color: Colors.black87),
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
                                text: 'Email: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.dialNeed.email.toString() ?? '',
                                style: const TextStyle(color: Colors.black87),
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
                                text: 'Address: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.dialNeed.address.toString() ?? '',
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Other Charges Details:-",
                    style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              for (var otherCharge in widget.dialNeed.otherCharges)
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.deepPurple.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '${otherCharge.name ?? 'N/A'}: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: otherCharge.amount ?? '',
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Product Details:-",
                    style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: {
                  0: const FlexColumnWidth(3),
                  1: const FlexColumnWidth(2),
                  2: const FlexColumnWidth(2),
                  3: const FlexColumnWidth(2),
                },
                children: [
                  const TableRow(
                    // decoration: BoxDecoration(color: Colors.deepPurple.shade50),
                    children: [
                      TableCell(
                        child: Center(
                            child: Text(
                          'Product Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                      ),
                      TableCell(
                          child: Center(
                              child: Text('Unit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)))),
                      TableCell(
                          child: Center(
                              child: Text('Quantity',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)))),
                      TableCell(
                          child: Center(
                              child: Text('Rate',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)))),
                    ],
                  ),
                  for (var productDetail in widget.dialNeed.productdetails)
                    TableRow(
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Center(
                                child: Text(
                              '${productDetail['product_name'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ))),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Center(
                                child: Text(
                              '${productDetail['unit_name'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ))),
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Center(
                                child: Text(
                              // productDetail.qnt ?? '',
                              '${productDetail['qnt'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ))),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: Text(
                            // productDetail.rate ?? '',
                            '${productDetail['rate'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16),
                          )),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
