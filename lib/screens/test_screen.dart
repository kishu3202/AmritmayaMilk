import 'package:amritmaya_milk/provider/deliveryBoyProvider/productList_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainTestScreen extends StatefulWidget {
  const MainTestScreen({super.key});

  @override
  State<MainTestScreen> createState() => _MainTestScreenState();
}

class _MainTestScreenState extends State<MainTestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = Provider.of<ProductListProvider>(context, listen: false);
    if (model.productCards.isEmpty) {
      final productCard = ProductCard(
          productName: "",
          productId: '',
          unitName: '',
          unitId: '',
          quantity: '',
          rate: '',
          id: 0);
      model.addCard(productCard);
    }
    if (model.otherCharges.isEmpty) {
      model.fetchOtherCharges();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productCards = context.select<ProductListProvider, List<ProductCard>>(
        (model) => model.productCards);
    final model = Provider.of<ProductListProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
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
                },
                child: Text("Add button"),
              ),
              Column(
                children: [
                  for (var productCard in model.productCards)
                    ProductCardWidget(index: productCard.id ?? 0),
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
                              final amount = model.otherCharges[index].amount;
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade50,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Transform.translate(
                                  offset: Offset(-10, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    child: CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
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
                                                'otherChargeId', model.otherId);
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
                                            model.otherCharge.remove(amount);
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
                  onPressed: () async {
                    // await model.submit(use);
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

class ProductCardWidget extends StatefulWidget {
  ProductCardWidget({required this.index});
  final int index;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  // String? selectedProduct;
  // String? selectedUnit;
  // String? selectedQuantity;
  // String? selectedRate;

  // List<ProductunitList> unitList = [];
  // List<ProductqntList> quantityList = [];
  // String rate = '';

  //

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
                  Text(widget.index.toString()),
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
                        // model.removeSelectedUnitId(widget.index);
                        // model.removeSelectedQuantity(widget.index);
                        // model.removeSelectedRate(widget.index);
                        // setState(() {
                        //   unitList = [];
                        //   quantityList = [];
                        //   rate = '';
                        // });
                        await model.fetchUnitIds(widget.index, selectedValue);
                        // setState(() {
                        //   unitList = unitListData;
                        // });
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
                          // model.removeSelectedQuantity(widget.index);
                          // model.removeSelectedRate(widget.index);
                          // setState(() {
                          //   quantityList = [];
                          //   rate = '';
                          // });
                          await model.fetchQuantityIds(
                            widget.index,
                            model.selectedProductIdMap[widget.index]!,
                            selectedValue,
                          );
                          // setState(() {
                          //   quantityList = quantityListData;
                          // });
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
                        // setState(() {
                        //   rate = '';
                        // });
                        model.setSelectedQuantity(widget.index, selectedValue);
                        // setState(() {
                        //   rate = rateListData;
                        // });
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
                        //   setState(() {
                        //   selectedRate = selectedValue;
                        // });
                        // final card = model.productCards[widget.index];
                        // final updatedCard = ProductCard(
                        //   unitId: card.unitId,
                        //   unitName: card.unitName,
                        //   productId: card.productId,
                        //   productName: card.productName,
                        //   quantity: card.quantity,
                        //   rate: selectedRate,
                        // );
                        // model.updateCard(widget.index, updatedCard);
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
                      // model.productCards.forEach((element) {
                      //   print(
                      //       "${element.productId}  ${element.productName} ${element.unitId} ${element.unitName} ${element.quantity} ${element.rate}");
                      // });
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
