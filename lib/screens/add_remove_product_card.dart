import 'package:flutter/material.dart';

class AddRemoveProductCard extends StatefulWidget {
  const AddRemoveProductCard({super.key});

  @override
  State<AddRemoveProductCard> createState() => _AddRemoveProductCardState();
}

class _AddRemoveProductCardState extends State<AddRemoveProductCard> {
  List<ProductData> _productDataList = [];

  // TextEditingController productController = TextEditingController();
  // TextEditingController quantityController = TextEditingController();
  // TextEditingController rateController = TextEditingController();
  String productName = '';
  String quantity = "";
  String rate = "";

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
              // controller: productController,
              onChanged: (value) {
                setState(() {
                  _productDataList[index].productName = value;
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
              // controller: productController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _productDataList[index].quantity = value;
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
              // controller: productController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _productDataList[index].rate = value;
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
                                productName: "", rate: "", quantity: "0"));
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
                          removeCard(index);
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

  void removeCard(String index) {
    _productDataList.removeAt(index as int);
  }
}

class ProductData {
  String productName;
  String quantity;
  String rate;

  ProductData(
      {required this.productName, required this.rate, required this.quantity});
}
