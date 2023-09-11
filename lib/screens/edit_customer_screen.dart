import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditCustomer extends StatefulWidget {
  const EditCustomer({Key? key, required this.customer}) : super(key: key);
  final customer;

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final formKey = GlobalKey<FormState>();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerContactController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  String id = '';

  @override
  void initState() {
    fetchCustomerDetails();
    super.initState();
  }

  void fetchCustomerDetails() async {
    id = widget.customer.id.toString();
    customerNameController.text = widget.customer.name;
    customerEmailController.text = widget.customer.email;
    customerContactController.text = widget.customer.contact;
    customerAddressController.text = widget.customer.address;
  }

  void submitCustomerData() async {
    var updatedCustomer = new Map<String, dynamic>();
    updatedCustomer['id'] = id;
    updatedCustomer['name'] = customerNameController.text;
    updatedCustomer['contact'] = customerContactController.text;
    updatedCustomer['email'] = customerEmailController.text;
    updatedCustomer['address'] = customerAddressController.text;

    final String url =
        "http://webiipl.in/amritmayamilk/api/DeliveryBoyApiController/customer_update";
    final Map<String, String> headers = {'X-API-KEY': 'amritmayamilk050512'};
    final http.Response response = await http.post(Uri.parse(url),
        headers: headers, body: updatedCustomer);

    Map<String, dynamic> res = json.decode(response.body);
    if (res['Success'] == true) {
      Fluttertoast.showToast(
          msg: 'Customer Details Update have been save Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);
      print("customer data updated");
    } else {
      Fluttertoast.showToast(
          msg: 'Failed to update details!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      print("update failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Customer Details"),
          centerTitle: true,
          // automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: customerNameController,
                    decoration: InputDecoration(
                        hintText: 'Name',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: customerEmailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: customerContactController,
                    decoration: InputDecoration(
                        hintText: 'Contact',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: customerAddressController,
                    decoration: InputDecoration(
                        hintText: 'Address',
                        prefixIcon: const Icon(Icons.location_city),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: submitCustomerData,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
