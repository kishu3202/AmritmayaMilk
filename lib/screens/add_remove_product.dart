import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRemoveProductCard extends StatefulWidget {
  AddRemoveProductCard(
      {super.key,
      required this.index,
      required this.onDelete,
      required productData});
  var index;
  final onDelete;

  @override
  State<AddRemoveProductCard> createState() => _AddRemoveProductCardState();
}

class _AddRemoveProductCardState extends State<AddRemoveProductCard> {
  List<ProductData> _productDataList = [];

  TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  String productName = '';
  String quantity = "";
  String rate = "";

  void removeCard(String index) {
    _productDataList.removeAt(index as int);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataList =
        _productDataList.map((data) => data.toString()).toList();
    prefs.setStringList('productDataList', dataList);
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final dataList = prefs.getStringList('productDataList');
    if (dataList != null) {
      setState(() {
        _productDataList.clear();
        for (final data in dataList) {
          final parts = data.split(',');
          _productDataList.add(ProductData(
            productName: parts[0],
            rate: parts[1],
            quantity: parts[2],
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.deepPurple.shade50),
      ),
      color: Colors.deepPurple.shade50,
      shadowColor: Color.alphaBlend(Colors.black87, Colors.black12),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              controller: productController,
              onChanged: (value) {
                setState(() {
                  productName = value;
                });
              },
              decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  quantity = value;
                });
              },
              decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  rate = value;
                });
              },
              decoration: InputDecoration(
                  labelText: 'Rate',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _productDataList.add(ProductData(
                                productName: productController.text,
                                rate: rateController.text,
                                quantity: quantityController.text));
                            saveData();
                            printData();
                          });
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onDelete(widget.index);
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
    );
  }

  void printData() {
    for (var data in _productDataList) {
      print(
          'Product Name: ${data.productName}, Rate: ${data.rate}, Quantity: ${data.quantity}');
    }
  }
}

class ProductData {
  String productName;
  String quantity;
  String rate;

  ProductData(
      {required this.productName, required this.rate, required this.quantity});
}
