import 'package:amritmaya_milk/screens/showAddRemoveProductList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_remove_product.dart';

class AddRemoveMultipleProduct extends StatefulWidget {
  const AddRemoveMultipleProduct({super.key});

  @override
  State<AddRemoveMultipleProduct> createState() =>
      _AddRemoveMultipleProductState();
}

class _AddRemoveMultipleProductState extends State<AddRemoveMultipleProduct> {
  List<AddRemoveProductCard> productCards = [
    // AddRemoveProductCard(index: index, onDelete: onDelete)
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productDataList = prefs.getStringList('productDataList');
    if (productDataList != null) {
      List<ProductData> products = productDataList.map((dataString) {
        List<String> data = dataString.split(',');
        return ProductData(
          productName: data[0],
          quantity: data[1],
          rate: data[2],
        );
      }).toList();
      setState(() {
        productCards = products
            .asMap()
            .map((index, productData) => MapEntry(
                  index,
                  AddRemoveProductCard(
                    index: index,
                    onDelete: _removeCard,
                    productData: productData,
                  ),
                ))
            .values
            .toList();
      });
    }
  }

  void _removeCard(int index) {
    setState(() {
      productCards.removeAt(index);
      for (int i = index; i < productCards.length; i++) {
        (productCards[i] as AddRemoveProductCard).index = i;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Multiple Product'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          productCards.add(AddRemoveProductCard(
                            index: productCards.length,
                            onDelete: (index) {
                              print('index');
                              _removeCard(index);
                            },
                            productData: null,
                          ));
                        });
                      },
                      child: Text(
                        'Add More',
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Flexible(
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        showProduct(context);
                      },
                      child: Text(
                        'Show',
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: productCards.length,
                itemBuilder: (context, index) {
                  return productCards[index];
                }),
          )
        ],
      ),
    );
  }

  void showProduct(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowAddRemoveProductList(
                  products: [],
                )));
  }
}
