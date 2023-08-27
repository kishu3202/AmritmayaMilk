import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool isFirstCardFilled = false;

  String userId = '';

  String? selectedProductId;
  int? selectedProductIndex;
  int? selectedUnitIndex;
  String? selectedUnitId;
  String? selectedQuantity;
  String? selectedRate;

  List<String> selectedProductNameList = [""];
  List<String> selectedProductIdList = [""];
  List<String> selectedUnitNameList = [""];
  List<String> selectedUnitIdList = [""];
  List<String> selectedQuantityNameList = [""];
  List<String> selectedRateList = [""];
  List<String> otherCharge = [""];
  List<String> otherId = [""];

  @override
  void initState() {
    super.initState();
    // cardAdd.add(addProductCard());
    // fetchOtherChargesId();
    // fetchOtherId();
    fetchUserId();
  }

  void fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id') ?? '';
    });
    print("stafffff id: ${userId}");
  }

  // void fetchOtherId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   otherId = prefs.getStringList('otherChargeId') ?? [];
  //   print('other Chargeeee: ${otherCharge}');
  // }
  //
  // void fetchOtherChargesId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     otherCharge = (prefs.getString('otherChargesAmounts') ?? '') as List<String>;
  //   });
  //   print("otherChargeeeee: ${otherCharge}");
  // }

  Future<void> _saveDailyNeedProductDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customer_id', widget.customerId);
    prefs.setString('staff_id', userId ?? '');
    // prefs.setString('other_id', otherId ?? '');
    prefs.setString('selected_product', selectedProductId ?? '');
    prefs.setString('selected_unit', selectedUnitId ?? '');
    prefs.setString('selected_quantity', selectedQuantity ?? '');
    prefs.setString('selected_rate', selectedRate ?? '');
    // prefs.setStringList('other_charges_id', otherCharge ?? );
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
      if (productData.otherId.isEmpty) {
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
          await productData.submit(
              context,
              selectedProductIdList,
              selectedUnitIdList,
              selectedQuantityNameList,
              selectedRateList,
              productData.otherCharge,
              productData.otherId,
              userId,
              widget.customerId);
        } catch (e) {
          print("Error during data submission: ${e}");
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
                    addProductCard(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (isFirstCardFilled) {
                                setState(() {
                                  // cardAdd.add(addProductCard());
                                  selectedProductNameList.insert(
                                      selectedProductNameList.length, "");
                                  selectedProductIdList.insert(
                                      selectedProductIdList.length, "");
                                  selectedUnitNameList.insert(
                                      selectedUnitNameList.length, "");
                                  selectedUnitIdList.insert(
                                      selectedUnitIdList.length, "");
                                  selectedQuantityNameList.insert(
                                      selectedQuantityNameList.length, "");
                                  selectedRateList.insert(
                                      selectedRateList.length, "");
                                  isFirstCardFilled = false;
                                });
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Please fill the details before add another card",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
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
                                          final amount =
                                              productData.amountList[index];
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
                                                    value: productData.otherId
                                                        .contains(id),
                                                    onChanged: (value) async {
                                                      print(
                                                          "Checkbox onChanged - Value: $value");
                                                      if (value!) {
                                                        print(
                                                            "Adding ID: $id to otherId list");
                                                        print(
                                                            "Adding amount: $amount to otherCharge list");
                                                        productData.otherId
                                                            .add(id);
                                                        productData.otherCharge
                                                            .add(amount);
                                                        SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        await prefs
                                                            .setStringList(
                                                                'otherChargeId',
                                                                productData
                                                                    .otherId);
                                                        SharedPreferences
                                                            prefss =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        await prefss.setStringList(
                                                            'otherChargesAmount',
                                                            productData
                                                                .otherCharge);
                                                        print(
                                                            "Saved otherChargeId in SharedPreferences: ${productData.otherId}");
                                                        print(
                                                            "Saved otherChargeAmount in SharedPreferences: ${productData.otherCharge}");
                                                      } else {
                                                        print(
                                                            "Removing ID: $id from otherCharge list");
                                                        productData.otherId
                                                            .remove(id);
                                                        productData.otherCharge
                                                            .remove(amount);
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
    return ListView.builder(
        itemCount: selectedProductNameList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
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
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  value: productData.selectedProductId,
                                  items: productData.productNameList
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      // value: productData.productIdList[
                                      //     productData.productNameList.indexOf(value)],
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedValue) {
                                    setState(() {
                                      selectedProductNameList[index] =
                                          selectedValue!;
                                      selectedProductIndex = productData
                                          .productNameList
                                          .indexOf(selectedValue);
                                      selectedProductId = productData
                                          .productIdList
                                          .elementAt(selectedProductIndex!);
                                      selectedProductIdList[index] =
                                          selectedProductId!;
                                      productData.fetchUnitIds(
                                          selectedProductIdList[index]);
                                      // print(
                                      //     "selected Product: ${selectedProductIdList[index]}");

                                      bool allDetailsFilled = true;
                                      if (allDetailsFilled &&
                                          index ==
                                              selectedProductNameList.length -
                                                  1) {
                                        isFirstCardFilled = true;
                                      }
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
                                    // hintText: selectedProductNameList[index],
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
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                value: productData.selectedUnitId,
                                items: productData.unitNameList
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    // value: productData.unitIdList[
                                    //     productData.unitNameList.indexOf(value)],
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? selectedValue) {
                                  setState(() {
                                    selectedUnitNameList[index] =
                                        selectedValue!;
                                    selectedUnitIndex = productData.unitNameList
                                        .indexOf(selectedValue);
                                    selectedUnitId = productData.unitIdList
                                        .elementAt(selectedUnitIndex!);
                                    selectedUnitIdList[index] = selectedUnitId!;
                                    productData.fetchQuantityIds(
                                        selectedProductIdList[index],
                                        selectedUnitIdList[index]);
                                    print(
                                        'selected unit: ${selectedUnitIdList[index]}');

                                    bool allDetailsFilled = true;
                                    if (allDetailsFilled &&
                                        index ==
                                            selectedUnitNameList.length - 1) {
                                      isFirstCardFilled = true;
                                    }
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
                                  // hintText: selectedUnitNameList[index],
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
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                value: productData.selectedQuantity,
                                items: productData.quantityList
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    // value: productData.quantityList[
                                    //     productData.quantityList.indexOf(value)],
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? selectedValue) {
                                  setState(() {
                                    selectedQuantityNameList[index] =
                                        selectedValue!;
                                    selectedQuantity = selectedValue;
                                    productData.fetchRates(
                                        selectedProductIdList[index],
                                        selectedUnitIdList[index],
                                        selectedQuantityNameList[index]);
                                    print(
                                        'selected quantity: ${selectedQuantityNameList[index]}');

                                    bool allDetailsFilled = true;
                                    if (allDetailsFilled &&
                                        index ==
                                            selectedQuantityNameList.length -
                                                1) {
                                      isFirstCardFilled = true;
                                    }
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
                                  // hintText: selectedQuantityNameList[index],
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
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                // isExpanded: true,
                                value: productData.selectedRate,
                                items: productData.rateList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? selectedValue) async {
                                  setState(() {
                                    selectedRateList[index] = selectedValue!;
                                    selectedRate = selectedValue;
                                    // productData.fetchProductNames();
                                    // productData.fetchUnitIds(
                                    //     productData.selectedProductId!);
                                    // await productData.fetchQuantityIds(
                                    //   productData.selectedProductId!,
                                    //   productData.selectedUnitId!,
                                    // );

                                    bool allDetailsFilled = true;
                                    if (allDetailsFilled &&
                                        index == selectedRateList.length - 1) {
                                      isFirstCardFilled = true;
                                    }
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
                                  labelText: "Rate",
                                  // hintText: selectedRateList[index],
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
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedProductNameList.removeAt(index);
                              selectedProductIdList.removeAt(index);
                              selectedUnitNameList.removeAt(index);
                              selectedUnitIdList.removeAt(index);
                              selectedQuantityNameList.removeAt(index);
                              selectedRateList.removeAt(index);
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
            ),
          );
        });
  }
}
