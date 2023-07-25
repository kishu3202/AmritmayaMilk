import 'package:flutter/material.dart';

class ShowAddRemoveProductList extends StatefulWidget {
  final products;
  const ShowAddRemoveProductList({super.key, this.products});

  @override
  State<ShowAddRemoveProductList> createState() =>
      _ShowAddRemoveProductListState();
}

class _ShowAddRemoveProductListState extends State<ShowAddRemoveProductList> {
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
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products![index];
                  return ListTile(
                    title: Text('Product Name : ${product.productName}'),
                    subtitle: Text(
                        'Quantity: ${product.quantity}, Rate: ${product.rate}'),
                  );
                }),
          )
        ],
      ),
    );
  }
}
