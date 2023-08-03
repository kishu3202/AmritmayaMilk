import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/productList_data_model.dart';
import '../data/productQuantity_data_model.dart';
import '../data/productRate_data_model.dart';
import '../data/productUnit_data_model.dart';
import '../provider/productList_Provider.dart';

class ProductListScreen extends StatefulWidget {
  final String customerId;
  const ProductListScreen({super.key, required this.customerId});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final formKey = GlobalKey<FormState>();

  final ProductListProvider productListProvider = ProductListProvider();

  // Initialize dropdown values to null
  String? selectedProduct;
  String? selectedUnit;
  String? selectedQuantity;
  String? selectedRate;

  bool? polytheneSmallChecked = false;
  bool? polytheneBigChecked = false;
  bool? deliveryChecked = false;
  bool? maintenanceChecked = false;

  String productId = '';
  String unitId = '';
  String quantityId = '';
  String rate = '';

// List to store fetched data
  List<ProductListElement> productList = [];
  List<ProductunitList> productunitList = [];
  List<ProductqntList> productqntList = [];
  ProductrateList? productrateList;

  @override
  void initState() {
    super.initState();
    _loadDailyNeedProductDetails();
  }

  Future<void> _loadDailyNeedProductDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedProduct = prefs.getString('selected_product') ?? null;
    selectedUnit = prefs.getString('selected_unit') ?? null;
    selectedQuantity = prefs.getString('selected_quantity') ?? null;
    selectedRate = prefs.getString('selected_rate') ?? null;
    polytheneSmallChecked = prefs.getBool('polythene_small_checked') ?? false;
    polytheneBigChecked = prefs.getBool('polythene_big_checked') ?? false;
    deliveryChecked = prefs.getBool('delivery_checked') ?? false;
    maintenanceChecked = prefs.getBool('maintenance_checked') ?? false;
    setState(() {}); // Refresh the UI after loading the details
  }

  // Function to save customer daily need product details to SharedPreferences
  Future<void> _saveDailyNeedProductDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customer_id', widget.customerId);
    prefs.setString('selected_product', selectedProduct!);
    prefs.setString('selected_unit', selectedUnit!);
    prefs.setString('selected_quantity', selectedQuantity!);
    prefs.setString('selected_rate', selectedRate!);
    prefs.setBool('polythene_small_checked', polytheneSmallChecked!);
    prefs.setBool('polythene_big_checked', polytheneBigChecked!);
    prefs.setBool('delivery_checked', deliveryChecked!);
    prefs.setBool('maintenance_checked', maintenanceChecked!);

    _showToastMessage("Daily need product details saved successfully");
    print('Daily need product saved successfully');
  }

  void _showToastMessage(String Message) {
    Fluttertoast.showToast(
      msg: Message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  Future<void> _submitDailyNeedProduct() async {
    if (!formKey.currentState!.validate()) {
      print('Please fill all the details');
    } else {
      if (!(polytheneSmallChecked! ||
          polytheneBigChecked! ||
          deliveryChecked! ||
          maintenanceChecked!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Please select at least one checkbox',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } else {
        try {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final productData =
              Provider.of<ProductListProvider>(context, listen: false);
          await productData.submitDailyNeedProduct();
          _showToastMessage("Daily Need has been saved Successfully");
        } catch (e) {
          _showToastMessage('Failed to save Daily Need');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productData =
        Provider.of<ProductListProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Daily Need Products"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Please specify daily need product details below",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(
                      color: Colors.black,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Builder(builder: (context) {
                              final productData =
                                  Provider.of<ProductListProvider>(context,
                                      listen: false);
                              return FutureBuilder(
                                future: productData.fetchProductNames(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return DropdownButtonFormField<String>(
                                      hint: const Text(
                                        'Product Name',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      value: productData.selectedProduct,
                                      items: productData.productNameList
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: productData.productIdList[
                                              productData.productNameList
                                                  .indexOf(value)],
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? selectedValue) {
                                        productData
                                            .setSelectedProduct(selectedValue!);
                                        productData.fetchUnitIds(
                                            productData.selectedProduct!);
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select an option';
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            }),
                            SizedBox(height: 20),
                            Consumer<ProductListProvider>(
                              builder: (context, productData, _) {
                                return DropdownButtonFormField<String>(
                                  hint: const Text(
                                    'Unit',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  value: productData.selectedUnit,
                                  items: productData.unitNameList
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: productData.unitIdList[productData
                                          .unitNameList
                                          .indexOf(value)],
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedValue) {
                                    selectedUnit = selectedValue!;
                                    productData
                                        .setSelectedUnitId(selectedValue!);
                                    productData.fetchQuantityIds(
                                      productData.selectedProduct!,
                                      productData.selectedUnit!,
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select an option';
                                    }
                                    return null;
                                  },
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.blue,
                                  ),
                                  dropdownColor: Colors.deepPurple.shade50,
                                  decoration: InputDecoration(
                                    labelText: "Unit",
                                    prefixIcon: const Icon(
                                      Icons.ad_units_outlined,
                                      color: Colors.blue,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            Consumer<ProductListProvider>(
                              builder: (context, productData, _) {
                                return DropdownButtonFormField<String>(
                                  hint: const Text(
                                    'Quantity',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  value: productData.selectedQuantity,
                                  items: productData.quantityList
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: productData.quantityList[
                                          productData.quantityList
                                              .indexOf(value)],
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedValue) {
                                    quantityId = selectedValue!;
                                    productData
                                        .setSelectedQuantityId(selectedValue);
                                    productData.fetchRates(
                                        productData.selectedProduct!,
                                        productData.selectedUnit!,
                                        productData.selectedQuantity!);
                                    print(selectedQuantity);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select an option';
                                    }
                                    return null;
                                  },
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.blue,
                                  ),
                                  dropdownColor: Colors.deepPurple.shade50,
                                  decoration: InputDecoration(
                                    labelText: "Quantity",
                                    prefixIcon: const Icon(
                                      Icons.production_quantity_limits,
                                      color: Colors.blue,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            Consumer<ProductListProvider>(
                              builder: (context, productData, _) {
                                print('Rate List: ${productData.rateList}');
                                return DropdownButtonFormField<String>(
                                  hint: const Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  value: productData.selectedRate,
                                  items:
                                      productData.rateList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedValue) {
                                    rate = selectedValue!;
                                    productData
                                        .setSelectedRateId(selectedValue!);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select an option';
                                    }
                                    return null;
                                  },
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.blue,
                                  ),
                                  dropdownColor: Colors.deepPurple.shade50,
                                  decoration: InputDecoration(
                                    labelText: "Rate",
                                    prefixIcon: const Icon(
                                      Icons.monetization_on,
                                      color: Colors.blue,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(
                      color: Colors.black,
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Other Charges",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Consumer<ProductListProvider>(
                            builder: (context, productData, _) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                    value: value, onChanged: onChanged);
                              });
                        }),
                      ],
                    )),
              ),

              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5.0),
              //       side: const BorderSide(
              //         color: Colors.black,
              //       )),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text(
              //           "Other Charges",
              //           style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black),
              //         ),
              //         const SizedBox(
              //           height: 16,
              //         ),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   color: Colors.deepPurple.shade50,
              //                   border: Border.all(
              //                     color: Colors.grey,
              //                     width: 1.0,
              //                   ),
              //                   borderRadius: BorderRadius.circular(5.0),
              //                 ),
              //                 child: Transform.translate(
              //                   offset: const Offset(-10, 0),
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.symmetric(horizontal: 1),
              //                     child: CheckboxListTile(
              //                       // tristate: true,
              //                       title: const Text(
              //                         'Polythene charges (Small)',
              //                         style: TextStyle(
              //                             color: Colors.black87, fontSize: 15),
              //                       ),
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(5.0),
              //                         // side: BorderSide(color: Colors.grey),
              //                       ),
              //                       value: polytheneSmallChecked,
              //                       onChanged: (value) {
              //                         setState(() {
              //                           polytheneSmallChecked = value;
              //                         });
              //                       },
              //                       controlAffinity:
              //                           ListTileControlAffinity.leading,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             const SizedBox(
              //               width: 5,
              //             ),
              //             Expanded(
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   color: Colors.deepPurple.shade50,
              //                   border: Border.all(
              //                     color: Colors.grey,
              //                     width: 1.0,
              //                   ),
              //                   borderRadius: BorderRadius.circular(5.0),
              //                 ),
              //                 child: Transform.translate(
              //                   offset: const Offset(-10, 0),
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.symmetric(horizontal: 1),
              //                     child: CheckboxListTile(
              //                       // tristate: true,
              //                       title: const Text(
              //                         'Polythene charges (Big)',
              //                         style: TextStyle(
              //                             color: Colors.black87, fontSize: 15),
              //                       ),
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(5.0),
              //                         // side: BorderSide(color: Colors.grey),
              //                       ),
              //                       value: polytheneBigChecked,
              //                       onChanged: (value) {
              //                         setState(() {
              //                           polytheneBigChecked = value;
              //                         });
              //                       },
              //                       controlAffinity:
              //                           ListTileControlAffinity.leading,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(
              //           height: 5,
              //         ),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   color: Colors.deepPurple.shade50,
              //                   border: Border.all(
              //                     color: Colors.grey,
              //                     width: 1.0,
              //                   ),
              //                   borderRadius: BorderRadius.circular(5.0),
              //                 ),
              //                 child: Transform.translate(
              //                   offset: const Offset(-10, 0),
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.symmetric(horizontal: 1),
              //                     child: CheckboxListTile(
              //                       // tristate: true,
              //                       title: const Text(
              //                         'Delivery charges',
              //                         style: TextStyle(
              //                             color: Colors.black87, fontSize: 15),
              //                       ),
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(5.0),
              //                         // side: BorderSide(color: Colors.grey),
              //                       ),
              //                       value: deliveryChecked,
              //                       onChanged: (value) {
              //                         setState(() {
              //                           deliveryChecked = value;
              //                         });
              //                       },
              //                       controlAffinity:
              //                           ListTileControlAffinity.leading,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             const SizedBox(
              //               width: 5,
              //             ),
              //             Expanded(
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   color: Colors.deepPurple.shade50,
              //                   border: Border.all(
              //                     color: Colors.grey,
              //                     width: 1.0,
              //                   ),
              //                   borderRadius: BorderRadius.circular(5.0),
              //                 ),
              //                 child: Transform.translate(
              //                   offset: const Offset(-10, 0),
              //                   child: Padding(
              //                     padding:
              //                         const EdgeInsets.symmetric(horizontal: 1),
              //                     child: CheckboxListTile(
              //                       // tristate: true,
              //                       title: const Text(
              //                         'Maintenance charges',
              //                         style: TextStyle(
              //                             color: Colors.black87, fontSize: 15),
              //                       ),
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(5.0),
              //                         // side: BorderSide(color: Colors.grey),
              //                       ),
              //                       value: maintenanceChecked,
              //                       onChanged: (value) {
              //                         setState(() {
              //                           maintenanceChecked = value;
              //                         });
              //                       },
              //                       controlAffinity:
              //                           ListTileControlAffinity.leading,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    _submitDailyNeedProduct();
                    _saveDailyNeedProductDetails();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
