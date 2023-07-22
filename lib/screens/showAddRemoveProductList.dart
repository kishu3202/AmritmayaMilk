import 'package:flutter/material.dart';

import 'add_remove_product_card.dart';

class ShowAddRemoveProductList extends StatelessWidget {
   // ShowAddRemoveProductList({super.key});
   final List<ProductData> _productDataList;

  ShowAddRemoveProductList({required this._productDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Product List'),
      ),
      body: ,
    );
  }
}
