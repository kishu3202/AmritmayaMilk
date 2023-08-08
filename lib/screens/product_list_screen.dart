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
  List<Widget> cardAdd = [];

  // Initialize dropdown values to null
  String? selectedProduct;
  String? selectedUnit;
  String? selectedQuantity;
  String? selectedRate;
  bool? selectedIds;

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
    cardAdd.add(addProductCard());
    _loadDailyNeedProductDetails();
  }

  Future<void> _loadDailyNeedProductDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedProduct = prefs.getString('selected_product') ?? null;
    selectedUnit = prefs.getString('selected_unit') ?? null;
    selectedQuantity = prefs.getString('selected_quantity') ?? null;
    selectedRate = prefs.getString('selected_rate') ?? null;
    selectedIds = prefs.getBool('polythene_small_checked') ?? false;
    selectedIds = prefs.getBool('polythene_big_checked') ?? false;
    selectedIds = prefs.getBool('delivery_checked') ?? false;
    selectedIds = prefs.getBool('maintenance_checked') ?? false;
    setState(() {}); // Refresh the UI after loading the details
  }

  // Function to save customer daily need product details to SharedPreferences
  Future<void> _saveDailyNeedProductDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customer_id', widget.customerId);
    prefs.setString('selected_product', selectedProduct ?? '');
    prefs.setString('selected_unit', selectedUnit ?? '');
    prefs.setString('selected_quantity', selectedQuantity ?? '');
    prefs.setString('selected_rate', selectedRate ?? '');

    prefs.setBool('polythene_small_checked', selectedIds ?? false);
    prefs.setBool('polythene_big_checked', selectedIds ?? false);
    prefs.setBool('delivery_checked', selectedIds ?? false);
    prefs.setBool('maintenance_checked', selectedIds ?? false);

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
    final productData =
        Provider.of<ProductListProvider>(context, listen: false);

    if (!formKey.currentState!.validate()) {
      print('Please fill all the details');
    } else {
      if (productData.selectedIds.isEmpty) {
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
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the previous screen with the customerId
        Navigator.pop(context, widget.customerId);
        return false; // Return false to allow the default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add Daily Need Products"),
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
                Column(
                  children: [
                    for (var index in cardAdd) addProductCard(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                cardAdd.add(addProductCard());
                              });
                            },
                            child: Text(
                              'Add More',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (cardAdd.length > 0) {
                                  cardAdd.removeLast();
                                }
                              });
                            },
                            child: Text(
                              'Remove',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                          FutureBuilder(
                              future: productData.fetchOtherCharges(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Consumer<ProductListProvider>(
                                      builder: (context, productData, _) {
                                    return GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          mainAxisExtent: 80,
                                        ),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: productData.nameList.length,
                                        itemBuilder: (context, index) {
                                          final name =
                                              productData.nameList[index];
                                          final id = productData.idList[index];
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Transform.translate(
                                              offset: Offset(-10, 0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text(productData
                                                        .nameList[index]),
                                                    value: productData
                                                        .selectedIds
                                                        .contains(id),
                                                    onChanged: (value) {
                                                      if (value!) {
                                                        productData.selectedIds
                                                            .add(id);
                                                      } else {
                                                        productData.selectedIds
                                                            .remove(id);
                                                      }
                                                      productData
                                                          .notifyListeners();
                                                    }),
                                              ),
                                            ),
                                          );
                                        });
                                  });
                                }
                              }),
                        ],
                      )),
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
      ),
    );
  }

  Widget addProductCard() {
    return Card(
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
                    final productData = Provider.of<ProductListProvider>(
                        context,
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            value: productData.selectedProduct,
                            items:
                                productData.productNameList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: productData.productIdList[
                                    productData.productNameList.indexOf(value)],
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? selectedValue) {
                              productData.setSelectedProduct(selectedValue!);
                              productData
                                  .fetchUnitIds(productData.selectedProduct!);
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
                                borderRadius: BorderRadius.circular(10),
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
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        value: productData.selectedUnit,
                        items: productData.unitNameList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: productData.unitIdList[
                                productData.unitNameList.indexOf(value)],
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? selectedValue) {
                          selectedUnit = selectedValue!;
                          productData.setSelectedUnitId(selectedValue!);
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
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        value: productData.selectedQuantity,
                        items: productData.quantityList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: productData.quantityList[
                                productData.quantityList.indexOf(value)],
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? selectedValue) {
                          quantityId = selectedValue!;
                          productData.setSelectedQuantityId(selectedValue);
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
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        value: productData.selectedRate,
                        items: productData.rateList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? selectedValue) {
                          rate = selectedValue!;
                          productData.setSelectedRateId(selectedValue!);
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
    );
  }
}
