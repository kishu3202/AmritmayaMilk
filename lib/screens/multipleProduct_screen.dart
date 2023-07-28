import 'package:flutter/material.dart';

class MultipleProductScreen extends StatefulWidget {
  @override
  _MultipleProductScreenState createState() => _MultipleProductScreenState();
}

class _MultipleProductScreenState extends State<MultipleProductScreen> {
  List<Product> products = [];

  void addProduct() {
    Product newProduct = Product(name: "", quantity: "", rate: "");
    setState(() {
      products.add(newProduct);
    });
  }

  void removeProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void showProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShowProductsPage(products: products)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Multiple Product")),
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
                      onPressed: addProduct,
                      child: Text(
                        "Add More",
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
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
                      onPressed: () => showProducts(),
                      child: Text("Show", style: TextStyle(fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: products[index],
                  onChanged: (name, quantity, rate) {
                    setState(() {
                      products[index].name = name;
                      products[index].quantity = quantity;
                      products[index].rate = rate;
                    });
                  },
                  onRemove: () => removeProduct(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  String name;
  String quantity;
  String rate;

  Product({required this.name, required this.quantity, required this.rate});
}

class ProductCard extends StatefulWidget {
  final Product product;
  final void Function(String, String, String) onChanged;
  final VoidCallback onRemove;

  ProductCard(
      {required this.product, required this.onChanged, required this.onRemove});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _rateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _quantityController = TextEditingController(text: widget.product.quantity);
    _rateController = TextEditingController(text: widget.product.rate);
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _quantityController.dispose();
    _rateController.dispose();
    super.dispose();
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
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) => widget.onChanged(
                  value, widget.product.quantity, widget.product.rate),
              decoration: InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: _nameController,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => widget.onChanged(
                  widget.product.name, value, widget.product.rate),
              decoration: InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: _quantityController,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => widget.onChanged(
                  widget.product.name, widget.product.quantity, value),
              decoration: InputDecoration(
                labelText: "Rate",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: _rateController,
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
                        onPressed: () => widget.onChanged(
                          _nameController.text,
                          _quantityController.text,
                          _rateController.text,
                        ),
                        child: Text(
                          "Add",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: widget.onRemove,
                        child: Text(
                          "Remove",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
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
}

class ShowProductsPage extends StatelessWidget {
  final List<Product> products;

  ShowProductsPage({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved Products")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Product Name: ${products[index].name}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quantity: ${products[index].quantity}"),
                Text("Rate: ${products[index].rate}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
