import 'package:amritmaya_milk/provider/userProvider/bill_Provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BillScreen extends StatefulWidget {
  final String customerId;
  const BillScreen({super.key, required this.customerId});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final _billFromKey = GlobalKey<FormState>();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  String fromDate = '';
  String toDate = '';

  @override
  void initState() {
    super.initState();
    resetBillData();
  }
  void resetBillData() {
    final billProvider = Provider.of<BillProvider>(context, listen: false);
    billProvider.monthlyBills = [];
    billProvider.totalAmount = null;
  }

  @override
  Widget build(BuildContext context) {
    final billProvider = Provider.of<BillProvider>(context);
    final bill = billProvider.monthlyBills;
    // final loading = billProvider.loading;
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: Form(
            key: _billFromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          onChanged: (value) async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              print(pickedDate);
                              String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);
                              setState(() {
                                fromDateController.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          keyboardType: TextInputType.datetime,
                          controller: fromDateController,
                          decoration: InputDecoration(
                            hintText: "Enter From Date",
                            labelText: 'From Date',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please enter from Date';
                            return null;
                          }),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                          onChanged: (value) async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              print(pickedDate);
                              String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);

                              setState(() {
                                toDateController.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          keyboardType: TextInputType.datetime,
                          controller: toDateController,
                          decoration: InputDecoration(
                            hintText: "Enter To Date",
                            labelText: 'To Date',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please enter to Date';
                            return null;
                          }),
                    ),
                  ],
                ),
                // TextFormField(
                //     onChanged: (value) async {
                //       DateTime? pickedDate = await showDatePicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime(2000),
                //           lastDate: DateTime(2101));
                //       if (pickedDate != null) {
                //         print(pickedDate);
                //         String formattedDate =
                //             DateFormat('yyyy-MM-dd').format(pickedDate);
                //         print(formattedDate);
                //         setState(() {
                //           fromDateController.text = formattedDate;
                //         });
                //       } else {
                //         print("Date is not selected");
                //       }
                //     },
                //     keyboardType: TextInputType.datetime,
                //     controller: fromDateController,
                //     decoration: InputDecoration(
                //       hintText: "Enter From Date",
                //       labelText: 'From Date (YYYY-MM-DD)',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       prefixIcon: const Icon(Icons.calendar_today),
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty)
                //         return 'Please enter from Date';
                //       return null;
                //     }),
                // SizedBox(height: 30),
                // TextFormField(
                //     onChanged: (value) async {
                //       DateTime? pickedDate = await showDatePicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime(2000),
                //           lastDate: DateTime(2101));
                //       if (pickedDate != null) {
                //         print(pickedDate);
                //         String formattedDate =
                //             DateFormat('yyyy-MM-dd').format(pickedDate);
                //         print(formattedDate);
                //
                //         setState(() {
                //           toDateController.text = formattedDate;
                //         });
                //       } else {
                //         print("Date is not selected");
                //       }
                //     },
                //     keyboardType: TextInputType.datetime,
                //     controller: toDateController,
                //     decoration: InputDecoration(
                //       hintText: "Enter To Date",
                //       labelText: 'To Date (YYYY-MM-DD)',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       prefixIcon: const Icon(Icons.calendar_today),
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty)
                //         return 'Please enter to Date';
                //       return null;
                //     }),
                SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    await billProvider.fetchBills(fromDateController.text,
                        toDateController.text, widget.customerId);
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 70,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Total Amount",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          "${billProvider.totalAmount ?? ""}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<void>(
                        // future: Future.value(null),
                        builder: (context, snapshot) {
                      return Consumer<BillProvider>(
                        builder: (context, billProvider, _) {
                          final bill = billProvider.monthlyBills;
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: bill.length,
                              itemBuilder: (context, index) {
                                final billItem = bill[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Colors.deepPurple.shade50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  text:
                                                      '${billItem['order_id'] ?? ''}',
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
                                                      '${billItem['created_at'] ?? ''}',
                                                  // '${DateFormat('yyyy-MM-dd').format(bill.createdAt)}',
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
                                                  text: 'Product Name: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${billItem['product_name'] ?? ''}',
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
                                                  text: 'Quantity: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${billItem['qnt'] ?? ''}',
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
                                                  text: 'Rate: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${billItem['rate'] ?? ''}',
                                                  style: const TextStyle(
                                                      color: Colors.black87),
                                                ),
                                              ],
                                            ),
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
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
