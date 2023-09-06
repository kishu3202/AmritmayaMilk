import 'package:amritmaya_milk/provider/deliveryBoyProvider/customerList_Provider.dart';
import 'package:amritmaya_milk/screens/edit_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    final customerModel = Provider.of<CustomerProvider>(context, listen: false);
    customerModel.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    final customerModel = Provider.of<CustomerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Customer List'),
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          // size: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          customerModel.post?[index].name ?? "",
                          // customers[index]['name'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.email,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          customerModel.post?[index].email ?? "",
                          //customers[index]['email'],
                          style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // callNumber('8379813263');
                          },
                          child: Text(
                            customerModel.post?[index].contact ?? "",
                            // customers[index]['contact'],
                            style: const TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_city,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          customerModel.post?[index].address ?? "",
                          // dataProvider.dat?.name ?? "",
                          // customers[index]['address'],
                          style: const TextStyle(
                              fontSize: 17,
                              fontStyle: FontStyle.normal,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditCustomer(
                                    customer: customerModel.post![index])));
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Customer {
  late final String name;
  late final String email;
  late final String contact;
  late final String address;

  Customer(
      {required this.name,
      required this.email,
      required this.contact,
      required this.address});
}
