import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<Product> products = [
    Product(
        'Farm Fresh Pure and Nutritious milk', ['Cow Milk', 'Buffalo Milk']),
    Product('Our Speciality loaded with High Protein and Good Fat',
        ['Fresh Panneer', 'Fresh Dahi', 'Ghee']),
    Product('Market Owned',
        ['Frozen Green Peas', 'Frozen Sweet Corn', 'French Fries']),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.deepPurple.shade50,
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      '${product.title}:',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: product.items.length,
                    itemBuilder: (context, itemIndex) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text((itemIndex + 1).toString()),
                        ),
                        title: Text(product.items[itemIndex]),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Product {
  final String title;
  final List<String> items;

  Product(this.title, this.items);
}
