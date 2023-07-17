import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final formKey = GlobalKey<FormState>();
  String? selectedProduct;
  String? selectedUnit;
  String? selectedQuantity;
  String? selectedRate;

  bool? polytheneSmallChecked = false;
  bool? polytheneBigChecked = false;
  bool? deliveryChecked = false;
  bool? maintenanceChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButtonFormField<String>(
                          value: selectedProduct,
                          hint: const Text(
                            'Product Name',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedProduct = newValue;
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
                              Icons.shopping_cart,
                              color: Colors.blue,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          items: <String>[
                            'Product 1',
                            'Product 2',
                            'Product 3',
                            'Product 4',
                            'Product 5',
                            'Product 6',
                            'Product 7',
                            'Product 8',
                            'Product 9',
                            'Product 10'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButtonFormField<String>(
                          value: selectedUnit,
                          hint: const Text(
                            'Unit',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedUnit = newValue;
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
                          items: <String>['1', '2', '3', '4', '5']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButtonFormField<String>(
                          value: selectedQuantity,
                          hint: const Text(
                            'Quantity',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedQuantity = newValue;
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
                          items: <String>['1', '2', '3', '4', '5']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButtonFormField<String>(
                          value: selectedRate,
                          hint: const Text(
                            'Rate',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRate = newValue;
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
                            prefixIcon: const Icon(
                              Icons.price_change_outlined,
                              color: Colors.blue,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          items: <String>['1', '2', '3', '4', '5']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: TextField(
                      //     onChanged: (value) {
                      //       unit = value;
                      //     },
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10)),
                      //         labelText: 'Unit'),
                      //     style:
                      //         const TextStyle(fontSize: 15, color: Colors.black),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: TextField(
                      //     onChanged: (value) {
                      //       quantity = value;
                      //     },
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10)),
                      //         labelText: 'Quantity'),
                      //     style:
                      //         const TextStyle(fontSize: 15, color: Colors.black),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: TextField(
                      //     onChanged: (value) {
                      //       rate = value;
                      //     },
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10)),
                      //         labelText: 'Rate'),
                      //     style:
                      //         const TextStyle(fontSize: 15, color: Colors.black),
                      //   ),
                      // ),
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
                    if (!formKey.currentState!.validate()) {
                      print(
                          "submit successful selectedProduct: ${selectedProduct}");
                      print(
                          "submit successful selectedProduct: ${selectedUnit}");
                      print(
                          "submit successful selectedProduct: ${selectedQuantity}");
                      print(
                          "submit successful selectedProduct: ${selectedRate}");
                      print('submit successful');
                    } else {
                      print("failed");
                    }
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
