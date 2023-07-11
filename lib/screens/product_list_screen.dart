import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedProduct = "Product 1";
  String? unit;
  String? quantity;
  String? rate;

  bool? polytheneSmallChecked = false;
  bool? polytheneBigChecked = false;
  bool? deliveryChecked = false;
  bool? maintenanceChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Daily Need Products"),
      ),
      body: SingleChildScrollView(
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
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(
                    color: Colors.black,
                  )),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: DropdownButtonFormField<String>(
                        value: selectedProduct,
                        hint: Text(
                          'Product Name',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedProduct = newValue;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.blue,
                        ),
                        dropdownColor: Colors.deepPurple.shade50,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          prefixIcon: Icon(
                            Icons.production_quantity_limits,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
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
                    SizedBox(
                      height: 6,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextField(
                        onChanged: (value) {
                          unit = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Unit'),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextField(
                        onChanged: (value) {
                          quantity = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Quantity'),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextField(
                        onChanged: (value) {
                          rate = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Rate'),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(
                    color: Colors.black,
                  )),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Other Charges",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
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
                              offset: Offset(-10, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: CheckboxListTile(
                                  tristate: true,
                                  title: Text(
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
                        SizedBox(
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
                              offset: Offset(-10, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: CheckboxListTile(
                                  tristate: true,
                                  title: Text(
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
                    SizedBox(
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
                              offset: Offset(-10, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: CheckboxListTile(
                                  tristate: true,
                                  title: Text(
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
                        SizedBox(
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
                              offset: Offset(-10, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: CheckboxListTile(
                                  tristate: true,
                                  title: Text(
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
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  print(
                      "submit successful selectedProduct: ${selectedProduct}");
                  print("submit successful selectedProduct: ${unit}");
                  print("submit successful selectedProduct: ${rate}");
                  print("submit successful selectedProduct: ${quantity}");
                  print('submit successful');
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
    );
  }
}
