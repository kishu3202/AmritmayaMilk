import 'package:amritmaya_milk/provider/userProvider/initimation_Provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/userProvider/userProduct_Provider.dart';

class IntimationScreen extends StatefulWidget {
  final String customerId;
  const IntimationScreen({super.key, required this.customerId});

  @override
  State<IntimationScreen> createState() => _IntimationScreenState();
}

class _IntimationScreenState extends State<IntimationScreen> {
  final _intimationFromKey = GlobalKey<FormState>();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController fromDateController1 = TextEditingController();
  TextEditingController toDateController1 = TextEditingController();
  int selectedOption = 0;
  String? selectedProductId;
  String? pauseTheService = '';
  String productId = '';
  String quantity = '';

  @override
  void initState() {
    super.initState();
    getProductData();
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
    final productProvider =
        Provider.of<UserProductProvider>(context, listen: false);

    final intimationProvider =
        Provider.of<IntimationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Intimation"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _intimationFromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 1),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio<int>(
                              value: 1,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              }),
                          const Text("Pause the Service"),
                          SizedBox(
                            width: 2,
                          ),
                          Row(
                            children: [
                              Radio<int>(
                                  value: 2,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value!;
                                    });
                                  }),
                              const Text("Change Product & Quantity"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (selectedOption == 1)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
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
                              labelText: 'From Date (YYYY-MM-DD)',
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
                        SizedBox(height: 30),
                        TextFormField(
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
                              labelText: 'From Date (YYYY-MM-DD)',
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
                        SizedBox(height: 50),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              final fromDate = fromDateController.text;
                              final toDate = toDateController.text;
                              if (fromDate.isNotEmpty && toDate.isNotEmpty) {
                                intimationProvider.postPauseTheService(
                                    context,
                                    widget.customerId,
                                    fromDate,
                                    toDate,
                                    pauseTheService!,
                                    productId,
                                    quantity);
                              } else if (_intimationFromKey.currentState!
                                  .validate()) {
                                Navigator.pop(context);
                                print('false');
                              }
                            });
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (selectedOption == 2)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          hint: Text('Select a product'),
                          value: selectedProductId,
                          items: productProvider.productIdList.map((productId) {
                            final index = productProvider.productIdList
                                .indexOf(productId);
                            return DropdownMenuItem<String>(
                              value: productId,
                              child:
                                  Text(productProvider.productNameList[index]),
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
                                  fromDateController1.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            keyboardType: TextInputType.datetime,
                            controller: fromDateController1,
                            decoration: InputDecoration(
                              hintText: "Enter From Date",
                              labelText: 'From Date (YYYY-MM-DD)',
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
                        SizedBox(height: 30),
                        TextFormField(
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
                                  toDateController1.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            keyboardType: TextInputType.datetime,
                            controller: toDateController1,
                            decoration: InputDecoration(
                              hintText: "Enter To Date",
                              labelText: 'From Date (YYYY-MM-DD)',
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
                        SizedBox(height: 50),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              final fromDate = fromDateController1.text;
                              final toDate = toDateController1.text;
                              if (fromDate.isNotEmpty && toDate.isNotEmpty) {
                                intimationProvider.postPauseTheService(
                                    context,
                                    widget.customerId,
                                    fromDate,
                                    toDate,
                                    pauseTheService!,
                                    selectedProductId!,
                                    quantity);
                              } else if (_intimationFromKey.currentState!
                                  .validate()) {
                                Navigator.pop(context);
                                print('false');
                              }
                            });
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
