import 'package:flutter/material.dart';

import 'add_remove_product_card.dart';

class AddRemoveMultipleProduct extends StatefulWidget {
  const AddRemoveMultipleProduct({super.key});

  @override
  State<AddRemoveMultipleProduct> createState() =>
      _AddRemoveMultipleProductState();
}

class _AddRemoveMultipleProductState extends State<AddRemoveMultipleProduct> {
  List<AddRemoveProductCard> productCards = [];
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
                          productCards.add(AddRemoveProductCard());
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
                      onPressed: () {},
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
}
