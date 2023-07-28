import 'package:amritmaya_milk/screens/customer_list_screen.dart';
import 'package:amritmaya_milk/screens/login_screen.dart';
import 'package:amritmaya_milk/screens/personalDetails_screen.dart';
import 'package:amritmaya_milk/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'multipleProduct_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanEnabled = false;
  String selectedMobileNumber = '';

  final List customers = [
    {
      'name': 'Kishori',
      'number': '8379813263',
      'address': 'Satara',
      'fromDate': '12/5/2023',
      'toDate': '11/6/2023',
    },
    {
      'name': 'Sagar',
      'number': '9689998016',
      'address': 'Pune',
      'fromDate': '15/8/2023',
      'toDate': '7/9/2023',
    },
    {
      'name': 'Poonam',
      'number': '7276573202',
      'address': 'Karad',
      'fromDate': '2/7,2023',
      'toDate': '3/6/2023',
    },
    {
      'name': 'Rohini',
      'number': '8975599697',
      'address': 'Sangli',
      'fromDate': '5/7/2023',
      'toDate': '11/8/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/042023',
      'toDate': '27/05/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/042023',
      'toDate': '27/05/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/042023',
      'toDate': '27/05/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/042023',
      'toDate': '27/05/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/042023',
      'toDate': '27/05/2023'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Close App'),
                  content: const Text('Do you want close an app?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No'),
                    ),
                  ],
                ));
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultipleProductScreen()));
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
          centerTitle: true,
          title: const Text('Dashboard'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonalDetails()));
              },
              icon: const Icon(Icons.person),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                showMessage(context, 'Are you sure to logout!');
              },
              icon: const Icon(Icons.logout_outlined),
              color: Colors.white,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScanScreen()),
                            );
                          },
                          child: const Text(
                            'QR Scanner',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CustomerList()),
                            );
                          },
                          child: const Text(
                            'Customer List',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  children: [
                    Text(
                      "Intimation List",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              decoration: ShapeDecoration(
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  customers[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              const TextSpan(
                                                text: 'Contact Number: ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.normal,
                                                    color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: customers[index]
                                                    ['number'],
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.normal,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            openDialPad(
                                                customers[index]['number']);
                                          },
                                          child: const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Address: ${customers[index]['address']}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black87),
                                    ),
                                    Text(
                                      'From Date: ${customers[index]['fromDate']}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black87),
                                    ),
                                    Text(
                                      'To Date: ${customers[index]['toDate']}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openDialPad(String mobileNumber) async {
    final url = 'tel: $mobileNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void showMessage(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Message'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}

Future<Future<bool?>> _showExitConfirmationDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Close App'),
        content: const Text('Are you sure you want to close the app?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
  );
}

class Customer {
  final String name;
  final int number;
  final String address;
  final DateTime fromDate;
  final DateTime toDate;

  Customer({
    required this.name,
    required this.number,
    required this.address,
    required this.fromDate,
    required this.toDate,
  });
}
