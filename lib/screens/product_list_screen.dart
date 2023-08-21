import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/productList_data_model.dart';
import '../data/productQuantity_data_model.dart';
import '../data/productRate_data_model.dart';
import '../data/productUnit_data_model.dart';
import '../provider/dailyNeedList_Provider.dart';
import '../provider/productList_Provider.dart';

class ProductListScreen extends StatefulWidget {
  final String customerId;
  const ProductListScreen({
    super.key,
    required this.customerId,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ProductListProvider productListProvider = ProductListProvider();
  List<Widget> cardAdd = [];

  // List to store fetched data
  List<ProductListElement> productList = [];
  List<ProductunitList> productunitList = [];
  List<ProductqntList> productqntList = [];
  ProductrateList? productrateList;

  int? productIdLength;
  int? unitIdLength;
  int? quantityLength;
  int? rateLength;
  int? otherChargesLength;
  int? otherIdLength;

  String userId = '';
  String otherId = '';
  String otherCharge = '';

  String? selectedProductId;
  int? selectedProductIndex;
  int? selectedUnitIndex;
  String? selectedUnitId;
  String? selectedQuantity;
  String? selectedRate;
  String? staffId;

  String productId = '';
  String unitId = '';
  String quantityId = '';
  String rate = '';

  @override
  void initState() {
    super.initState();
    cardAdd.add(addProductCard());
    fetchOtherChargesId();
    fetchOtherId();
    fetchUserId();
    _formKey.currentState?.reset();
  }

  void fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id') ?? '';
    });
  }

  void fetchOtherId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      otherId = prefs.getString('otherChargesIds') ?? '';
    });
  }

  void fetchOtherChargesId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      otherCharge = prefs.getString('otherChargesAmounts') ?? '';
    });
  }

  Future<void> _saveDailyNeedProductDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customer_id', widget.customerId);
    prefs.setString('staff_id', userId ?? '');
    prefs.setString('other_id', otherId ?? '');
    prefs.setString('selected_product', selectedProductId ?? '');
    prefs.setString('selected_unit', selectedUnitId ?? '');
    prefs.setString('selected_quantity', selectedQuantity ?? '');
    prefs.setString('selected_rate', selectedRate ?? '');
    prefs.setString('other_charges_id', otherCharge ?? '');
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

  Future<void> _submitDailyNeedProduct(BuildContext context) async {
    final productData =
        Provider.of<ProductListProvider>(context, listen: false);

    if (!_formKey.currentState!.validate()) {
      print('Please fill all the details');
    } else {
      if (productData.otherCharge.isEmpty) {
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
          // await productData.submit(
          //     context,
          //     selectedProductId!,
          //     selectedUnitId!,
          //     selectedQuantity!,
          //     selectedRate!,
          //     otherCharge,
          //     otherId,
          //     userId,
          //     widget.customerId);
          var headers = {
            'X-API-KEY': 'amritmayamilk050512',
          };
          var uri = Uri.parse(
              'https://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/dailyNeedProduct');
          var data = {
            'customer_id': widget.customerId.toString(),
            'staff_id': userId,
          };
          print('Selected Product List: ${selectedProductId}');
          print('Selected Unit List: ${selectedUnitId}');
          print('Selected Quantity List: ${productData.selectedQuantity}');
          print('Selected Rate List: ${productData.selectedRate}');
          print('Other Charge List: ${productData.otherCharge}');
          print('Other ID List: ${otherId}');

          for (int i = 0; i < selectedProductId!.length; i++) {
            data['product_id[]'] = selectedProductId![i];
            data['unit_id[]'] = selectedUnitId![i];
            data['qnt[]'] = productData.selectedQuantity![i];
            data['rate[]'] = productData.selectedRate![i];
            data['other_charges[]'] = productData.otherCharge[i];
            // data['other_id[]'] = otherId[i];
            if (i < otherId.length) {
              data['other_id[]'] = otherId[i];
            } else {
              data['other_id[]'] = ''; // Or any default value
            }
          }
          var response = await http.post(uri, headers: headers, body: data);
          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            print('Response JSON Data: $jsonData');
            print('Success: ${jsonData["Success"]}');
            print(jsonData["Success"]);
            _showToastMessage("Daily Need has been saved Successfully");

            final dailyNeedProvider =
                Provider.of<DailyNeedProductProvider>(context, listen: false);
            await dailyNeedProvider.getPostDailyNeedProduct(widget.customerId);
            dailyNeedProvider.notifyListeners();
          } else {
            Fluttertoast.showToast(
                msg: "Error Occurred", timeInSecForIosWeb: 25);
          }
        } catch (e) {
          print('Error during data submission: $e');
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
        Navigator.pop(context, widget.customerId);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add Daily Need Products"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                                                        .otherCharge
                                                        .contains(id),
                                                    onChanged: (value) {
                                                      if (value!) {
                                                        productData.otherCharge
                                                            .add(id);
                                                      } else {
                                                        productData.otherCharge
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
                      _submitDailyNeedProduct(context);
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
                            value: productData.selectedProductId,
                            items:
                                productData.productNameList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                // value: productData.productIdList[
                                //     productData.productNameList.indexOf(value)],
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? selectedValue) {
                              setState(() {
                                selectedProductIndex = productData
                                    .productNameList
                                    .indexOf(selectedValue!);
                                selectedProductId = productData.productIdList
                                    .elementAt(selectedProductIndex!);
                                productData.fetchUnitIds(selectedProductId!);
                                print("selected Product: $selectedProductId");
                              });
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
                  FutureBuilder(builder: (context, snapshot) {
                    return Consumer<ProductListProvider>(
                      builder: (context, productData, _) {
                        return DropdownButtonFormField<String>(
                          hint: const Text(
                            'Unit',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          value: productData.selectedUnitId,
                          items: productData.unitNameList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              // value: productData.unitIdList[
                              //     productData.unitNameList.indexOf(value)],
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? selectedValue) {
                            setState(() {
                              selectedUnitIndex = productData.unitNameList
                                  .indexOf(selectedValue!);
                              selectedUnitId = productData.unitIdList
                                  .elementAt(selectedUnitIndex!);
                              productData.fetchQuantityIds(
                                  selectedProductId!, selectedUnitId!);
                              print('selected unit: $selectedUnitId');
                            });
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
                    );
                  }),
                  SizedBox(height: 20),
                  FutureBuilder(builder: (context, snapshot) {
                    return Consumer<ProductListProvider>(
                      builder: (context, productData, _) {
                        return DropdownButtonFormField<String>(
                          hint: const Text(
                            'Quantity',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          value: productData.selectedQuantity,
                          items: productData.quantityList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              // value: productData.quantityList[
                              //     productData.quantityList.indexOf(value)],
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? selectedValue) {
                            setState(() {
                              productData.selectedQuantity = selectedValue!;
                              // productData.setSelectedQuantityId(selectedValue!);
                              productData.fetchRates(
                                  selectedProductId!,
                                  selectedUnitId!,
                                  productData.selectedQuantity!);
                              print(
                                  'selected quantity: $productData.selectedQuantity');
                            });
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
                    );
                  }),
                  SizedBox(height: 20),
                  FutureBuilder(builder: (context, snapshot) {
                    return Consumer<ProductListProvider>(
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
                          onChanged: (String? selectedValue) async {
                            productData.fetchProductNames();
                            productData
                                .fetchUnitIds(productData.selectedProductId!);
                            await productData.fetchQuantityIds(
                              productData.selectedProductId!,
                              productData.selectedUnitId!,
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
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget addCards() {
  return Container();
}

Widget removeCards() {
  return Container();
}
