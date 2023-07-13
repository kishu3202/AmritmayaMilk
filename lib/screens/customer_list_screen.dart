import 'package:amritmaya_milk/provider/customer_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool isEditing = false;
  // final List customers = [
  //   {
  //     'name': 'Kishori',
  //     'email': 'kishori@gmail.com',
  //     'phoneNo': '8379813263',
  //     'address': 'Pune'
  //   },
  //   {
  //     'name': 'Dipti',
  //     'email': 'dipti@gmail.com',
  //     'phoneNo': '8894561223',
  //     'address': 'Satara',
  //   },
  //   {
  //     'name': 'Rahul',
  //     'email': 'rahul@gmail.com',
  //     'phoneNo': '9689998016',
  //     'address': 'Sangli',
  //   },
  //   {
  //     'name': 'Sayali',
  //     'email': 'sayali@gmail.com',
  //     'phoneNo': '8975599697',
  //     'address': 'Mumbai',
  //   }
  // ];

  CustomerProvider? customerProvider;
  // @override
  // void initState() {
  //   super.initState();
  //   final customerProvider = Provider.of(context, listen: false);
  //   customerProvider.getPostData();
  // }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Customer List'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: ListView.builder(
          // itemCount: customers.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(5.5),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: const BorderSide(
                  color: Colors.black,
                ),
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
                          customerProvider.post?.name ?? "",
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
                          customerProvider.post?.email ?? "",
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
                            customerProvider.post?.contact ?? "",
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
                          customerProvider.post?.address ?? "",
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

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      contact: json['phone'] ?? "",
      address: json['address'] ?? "",
    );
  }
}
