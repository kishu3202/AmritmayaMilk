import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/deliveryBoyProvider/productList_Provider.dart';

class ProductListScreen extends StatefulWidget {
  final String customerId;
  final VoidCallback onNavigateBack;
  const ProductListScreen({
    super.key,
    required this.customerId,
    required this.onNavigateBack,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final productFormKey = GlobalKey<FormState>();
  String userId = '';
  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  void fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id') ?? '';
    });
    print("stafffff id: ${userId}");
  }

  void _showToastMessage(String Message) {
    Fluttertoast.showToast(
      msg: Message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = Provider.of<ProductListProvider>(context, listen: true);
    if (model.productCards.isEmpty) {
      final productCard = ProductCard(
          productName: "",
          productId: '',
          unitName: '',
          unitId: '',
          quantity: '',
          rate: '',
          id: 0);
      Future.delayed(Duration.zero, () {
        model.resetState();
        model.addCard(productCard);
      });
    }
    if (model.otherCharges.isEmpty) {
      model.fetchOtherCharges();
    }
  }

  Future<void> _submitDailyNeedProduct(BuildContext context) async {
    final model = Provider.of<ProductListProvider>(context, listen: false);
    if (!productFormKey.currentState!.validate()) {
      print('Please fill all the details');
    } else {
      if (model.otherId.isEmpty) {
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
          final submittedData = await model.submit(userId, widget.customerId);
          widget.onNavigateBack();
          Navigator.pop(context, true);
        } catch (e) {
          print("Error during data submission: ${e}");
        }
      }
    }
  }

  void _resetForm() {
    productFormKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProductListProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductListProvider>(context, listen: false)
            .resetState(); // Reset the state
        _resetForm();
        Navigator.pop(context, widget.customerId);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add Daily Need Products"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: productFormKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                        for (var productCard in model.productCards)
                          ProductCardWidget(index: productCard.id ?? 0),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final firstCard =
                            model.productCards.first; // Get the first card
                        // Check if any of the required values in the first card are not selected
                        if (firstCard.productId!.isEmpty ||
                            firstCard.unitId!.isEmpty ||
                            firstCard.quantity!.isEmpty ||
                            firstCard.rate!.isEmpty) {
                          _showToastMessage(
                              'Please fill all the details in the first card');
                        } else {
                          model.nextProductCardId();
                          final productCard = ProductCard(
                            productId: "",
                            productName: "",
                            unitId: "",
                            unitName: "",
                            quantity: "",
                            rate: "",
                            id: model.productCardId,
                          );
                          model.addCard(productCard);
                        }
                      },
                      child: Text(
                        "Add button",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
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
                              GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 80,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model.otherCharges.length,
                                  itemBuilder: (context, index) {
                                    final name = model.otherCharges[index].name;
                                    final id = model.otherCharges[index].id;
                                    final amount =
                                        model.otherCharges[index].amount;
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple.shade50,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Transform.translate(
                                        offset: Offset(-10, 0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1),
                                          child: CheckboxListTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              title: Text(name),
                                              // value: true,
                                              value: model.otherId.contains(id),
                                              onChanged: (value) async {
                                                print(
                                                    "Checkbox onChanged - Value: $value");
                                                if (value!) {
                                                  print(
                                                      "Adding ID: $id to otherId list");
                                                  print(
                                                      "Adding amount: $amount to otherCharge list");
                                                  model.otherId.add(id);
                                                  model.otherCharge.add(amount);
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await prefs.setStringList(
                                                      'otherChargeId',
                                                      model.otherId);
                                                  SharedPreferences prefss =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await prefss.setStringList(
                                                      'otherChargesAmount',
                                                      model.otherCharge);
                                                  print(
                                                      "Saved otherChargeId in SharedPreferences: ${model.otherId}");
                                                  print(
                                                      "Saved otherChargeAmount in SharedPreferences: ${model.otherCharge}");
                                                } else {
                                                  print(
                                                      "Removing ID: $id from otherCharge list");
                                                  model.otherId.remove(id);
                                                  model.otherCharge
                                                      .remove(amount);
                                                }
                                                model.notifyListeners();
                                              }),
                                        ),
                                      ),
                                    );
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
                          final submittedData =
                              _submitDailyNeedProduct(context);
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
        ),
      ),
    );
  }
}

class ProductCardWidget extends StatefulWidget {
  ProductCardWidget({required this.index});
  final int index;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final model = Provider.of<ProductListProvider>(context, listen: false);
    if (model.products.isEmpty) {
      model.fetchProductNames();
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProductListProvider>(context, listen: false);
    final unitlist = model.unitListDataMap[widget.index] ?? [];
    final quantitylist = model.quantityListDataMap[widget.index] ?? [];
    final rate = model.rateDataMap[widget.index] ?? "";
    print("unitList: ${unitlist}");
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
                  // Text(widget.index.toString()),
                  DropdownButtonFormField<String>(
                    hint: const Text(
                      'Product Name',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    value: model.selectedProductIdMap[widget.index],
                    items: model.products
                        .map(
                          (e) => DropdownMenuItem<String>(
                              value: e.id, child: Text(e.name)),
                        )
                        .toList(),
                    onChanged: (String? selectedValue) async {
                      if (selectedValue != null) {
                        final card = model.productCards[widget.index];
                        final productName = model.products
                            .firstWhere(
                                (element) => element.id == selectedValue)
                            .name;
                        print("unit list in card: ${productName}");
                        final updatedCard = card.copyWith(
                          productName: productName,
                          productId: selectedValue,
                        );
                        model.updateCard(widget.index, updatedCard);
                        await model.fetchUnitIds(widget.index, selectedValue);
                        model.setSelectedProductId(widget.index, selectedValue);
                      }
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    return DropdownButtonFormField<String>(
                      hint: const Text(
                        'Unit',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      value: model.selectedUnitIdMap[widget.index],
                      items: [
                        for (int i = 0; i < unitlist.length; i++)
                          DropdownMenuItem<String>(
                              value: unitlist[i].unitId,
                              child: Text('${unitlist[i].name}')),
                      ],
                      onChanged: (String? selectedValue) async {
                        if (selectedValue != null) {
                          final card = model.productCards[widget.index];
                          final unitName = unitlist
                              .firstWhere(
                                  (element) => element.unitId == selectedValue)
                              .name;
                          print("unit list in card: ${unitName}");
                          // return;
                          final updatedCard = card.copyWith(
                            unitName: unitName,
                            unitId: selectedValue,
                          );
                          model.updateCard(widget.index, updatedCard);
                          await model.fetchQuantityIds(
                            widget.index,
                            model.selectedProductIdMap[widget.index]!,
                            selectedValue,
                          );
                          model.setSelectedUnitId(widget.index, selectedValue);
                        }
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
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    hint: const Text(
                      'Quantity',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    value: model.selectedQuantityMap[widget.index],
                    items: [
                      for (int i = 0; i < quantitylist.length; i++)
                        DropdownMenuItem<String>(
                            value: quantitylist[i].qnt,
                            child: Text('${quantitylist[i].qnt}')),
                    ],
                    onChanged: (String? selectedValue) async {
                      if (selectedValue != null) {
                        final card = model.productCards[widget.index];
                        final updatedCard = card.copyWith(
                          quantity: selectedValue,
                        );
                        model.updateCard(widget.index, updatedCard);
                        // model.removeSelectedRate(widget.index);
                        await model.fetchRates(
                            widget.index,
                            model.selectedProductIdMap[widget.index]!,
                            model.selectedUnitIdMap[widget.index]!,
                            selectedValue);
                        model.setSelectedQuantity(widget.index, selectedValue);
                      }
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
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    hint: const Text(
                      'Rate',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    value: model.selectedRateMap[widget.index],
                    items: [
                      DropdownMenuItem<String>(
                          value: rate, child: Text('${rate}')),
                    ],
                    onChanged: (String? selectedValue) {
                      if (selectedValue != null) {
                        final card = model.productCards[widget.index];
                        final updatedCard = card.copyWith(
                          rate: selectedValue,
                        );
                        model.updateCard(widget.index, updatedCard);
                        model.setSelectedRate(widget.index, selectedValue);
                      }
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
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      model.removeCard(widget.index);
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
  }
}
