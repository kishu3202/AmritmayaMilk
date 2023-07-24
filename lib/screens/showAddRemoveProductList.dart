import 'package:flutter/material.dart';

import 'add_remove_product.dart';

class ShowAddRemoveProductList extends StatefulWidget {
  const ShowAddRemoveProductList(
      {super.key, required List<ProductData> products});

  @override
  State<ShowAddRemoveProductList> createState() =>
      _ShowAddRemoveProductListState();
}

class _ShowAddRemoveProductListState extends State<ShowAddRemoveProductList> {
  late List<ProductData> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Product List'),
      ),
      body: Column(
        children: [
          ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.productName),
                  subtitle: Text(
                      'Quantity: ${product.quantity}, Rate: ${product.rate}'),
                );
              })
        ],
      ),
    );
  }
}
