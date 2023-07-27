import 'package:amritmaya_milk/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  final String customerId;
  const FormScreen({super.key, required this.customerId});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Need Product List'),
        centerTitle: true,
      ),
      body: const Center(),
      floatingActionButton: Container(
        height: 60,
        width: 220,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  ProductListScreen(
                        customerId: widget.customerId,
                      )),
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: const Text(
            'Add Daily Need Products',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
