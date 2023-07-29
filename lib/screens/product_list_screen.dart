import 'dart:async';

import 'package:amritmaya_milk/provider/productQuantity_Provider.dart';
import 'package:amritmaya_milk/provider/productRate_Provider.dart';
import 'package:amritmaya_milk/provider/productUnit_Provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/productList_data_model.dart';
import '../data/productQuantity_data_model.dart';
import '../data/productRate_data_model.dart';
import '../data/productUnit_data_model.dart';
import '../provider/productList_Provider.dart';
import '../widget/string.dart';

class ProductListScreen extends StatefulWidget {
  final String customerId;
  const ProductListScreen({super.key, required this.customerId});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final formKey = GlobalKey<FormState>();

  // Initialize dropdown values to null
  String? selectedProduct = '';
  String? selectedUnit = '';
  String? selectedQuantity = '';
  String? selectedRate = '';

  bool? polytheneSmallChecked = false;
  bool? polytheneBigChecked = false;
  bool? deliveryChecked = false;
  bool? maintenanceChecked = false;

  String productId = '';
  String unitId = '';
  String quantityId = '';

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

  Future<void> getProductListData(BuildContext con) async {
    final bid = Provider.of<ProductListProvider>(context, listen: false);
    final res = await bid.getProductNameList();
  }

  Future<void> getProductUnitData(BuildContext con) async {
    final bid = Provider.of<ProductUnitProvider>(context, listen: false);
    final res = await bid.getProductUnitList(productId);
  }

  Future<void> getProductQuantityData(BuildContext con) async {
    final bid = Provider.of<ProductQuantityProvider>(context, listen: false);
    final res = await bid.getProductQuantityList(productId, unitId);
  }

  Future<void> getProductRateData(BuildContext con) async {
    final bid = Provider.of<ProductRateProvider>(context, listen: false);
    final res = await bid.getProductRateList(productId, unitId, quantityId);
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
  }

  final String baseUrl =
      'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct';
  final String apiKey = 'amritmayamilk050512';
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
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        // Construct the request body
        final Map<String, dynamic> data = {
          'customer_id': widget.customerId.toString(),
          'product_id[]': productId.toString(),
          'product_name': selectedProduct!,
          'unit_id[]': selectedUnit!,
          'qnt[]': selectedQuantity!,
          'rate': selectedRate!,
          'polythene_small': polytheneSmallChecked.toString(),
          'polythene_big': polytheneBigChecked.toString(),
          'delivery_charges': deliveryChecked.toString(),
          'maintenance_charges': maintenanceChecked.toString(),
        };
        final response = await http.post(
          Uri.parse(baseUrl),
          headers: {'X-API-KEY': apiKey},
          body: data,
        );

        if (response.statusCode == 200) {
          _showToastMessage("Daily Need has been saved Successfully");
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('customer_id', widget.customerId);
          print("Customer ID: ${widget.customerId}");
          print("Selected Product: $selectedProduct");
          print("Selected Unit: $selectedUnit");
          print("Selected Quantity: $selectedQuantity");
          print("Selected Rate: $selectedRate");
          print("Polythene Small Checked: $polytheneSmallChecked");
          print("Polythene Big Checked: $polytheneBigChecked");
          print("Delivery Checked: $deliveryChecked");
          print("Maintenance Checked: $maintenanceChecked");
        } else {
          _showToastMessage("Failed to save Daily Need");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productListProvider =
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
                      FutureBuilder(
                          future: getProductListData(context),
                          builder: (context, snapshot) => Consumer<
                                  ProductListProvider>(
                              builder: (con, productInfo, _) => Align(
                                    alignment: Alignment.topLeft,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedProduct,
                                      hint: const Text(
                                        'Product Name',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedProduct = newValue;
                                          print(
                                              'Selected Product: $selectedProduct');
                                          int selectedProductIndex = Strings
                                              .productNameList
                                              .indexOf(newValue!);
                                          String selectedProductId = Strings
                                              .productIdList
                                              .elementAt(selectedProductIndex);
                                        });
                                      },
                                      items: Strings.productNameList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );
                                      }).toList(),
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
                                          Icons.shopping_cart,
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
                                    ),
                                  ))),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: getProductUnitData(context),
                          builder: (context, snapshot) => Consumer<
                                  ProductListProvider>(
                              builder: (con, productInfo, _) => Align(
                                    alignment: Alignment.topLeft,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedUnit,
                                      hint: const Text(
                                        'Unit',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedUnit = newValue;
                                          print('Selected Unit: $selectedUnit');
                                          int selectedProductIndex = Strings
                                              .productNameList
                                              .indexOf(newValue!);
                                          String selectedProductId = Strings
                                              .productIdList
                                              .elementAt(selectedProductIndex);
                                        });
                                      },
                                      items: Strings.productUnitNameList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );
                                      }).toList(),
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
                                          Icons.shopping_cart,
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
                                    ),
                                  ))),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: getProductQuantityData(context),
                          builder: (context, snapshot) => Consumer<
                                  ProductListProvider>(
                              builder: (con, productInfo, _) => Align(
                                    alignment: Alignment.topLeft,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedQuantity,
                                      hint: const Text(
                                        'Quantity',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedQuantity = newValue;
                                          print(
                                              'Selected Quantity: $selectedQuantity');
                                          int selectedProductIndex = Strings
                                              .productNameList
                                              .indexOf(newValue!);
                                          String selectedProductId = Strings
                                              .productIdList
                                              .elementAt(selectedProductIndex);
                                        });
                                      },
                                      items: Strings.productQuantityNameList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );
                                      }).toList(),
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
                                          Icons.shopping_cart,
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
                                    ),
                                  ))),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: getProductRateData(context),
                          builder: (context, snapshot) => Consumer<
                                  ProductListProvider>(
                              builder: (con, productInfo, _) => Align(
                                    alignment: Alignment.topLeft,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedRate,
                                      hint: const Text(
                                        'Rate',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedRate = newValue;
                                          print('Selected Rate: $selectedRate');
                                          int selectedProductIndex = Strings
                                              .productNameList
                                              .indexOf(newValue!);
                                          String selectedProductId = Strings
                                              .productIdList
                                              .elementAt(selectedProductIndex);
                                        });
                                      },
                                      items: Strings.productRateNameList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );
                                      }).toList(),
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
                                          Icons.shopping_cart,
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
                                    ),
                                  ))),
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
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Transform.translate(
                                offset: const Offset(-10, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: CheckboxListTile(
                                    // tristate: true,
                                    title: const Text(
                                      'Polythene charges (Small)',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 15),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      // side: BorderSide(color: Colors.grey),
                                    ),
                                    value: polytheneSmallChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        polytheneSmallChecked = value;
                                      });
                                    },

                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Transform.translate(
                                offset: const Offset(-10, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: CheckboxListTile(
                                    // tristate: true,
                                    title: const Text(
                                      'Polythene charges (Big)',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 15),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      // side: BorderSide(color: Colors.grey),
                                    ),
                                    value: polytheneBigChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        polytheneBigChecked = value;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Transform.translate(
                                offset: const Offset(-10, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: CheckboxListTile(
                                    // tristate: true,
                                    title: const Text(
                                      'Delivery charges',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 15),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      // side: BorderSide(color: Colors.grey),
                                    ),
                                    value: deliveryChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        deliveryChecked = value;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Transform.translate(
                                offset: const Offset(-10, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: CheckboxListTile(
                                    // tristate: true,
                                    title: const Text(
                                      'Maintenance charges',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 15),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      // side: BorderSide(color: Colors.grey),
                                    ),
                                    value: maintenanceChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        maintenanceChecked = value;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
