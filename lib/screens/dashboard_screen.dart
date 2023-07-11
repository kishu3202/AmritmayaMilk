import 'package:amritmaya_milk/screens/customer_list_screen.dart';
import 'package:amritmaya_milk/screens/login_screen.dart';
import 'package:amritmaya_milk/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanEnabled = false;

  // var getResult = 'QR Code Result';

  // final List<Customer> customers = [
  //   Customer(
  //     name: 'Kishori',
  //     number: 8379813263,
  //     fromDate: DateTime(11, 06, 2023),
  //     toDate: DateTime(12, 7, 2023),
  //   ),
  //   Customer(
  //     name: 'Kishori',
  //     number: 8379813263,
  //     fromDate: DateTime(11, 06, 2023),
  //     toDate: DateTime(12, 7, 2023),
  //   ),
  //   Customer(
  //     name: 'Kishori',
  //     number: 8379813263,
  //     fromDate: DateTime(11, 06, 2023),
  //     toDate: DateTime(12, 7, 2023),
  //   ),
  //   Customer(
  //     name: 'Kishori',
  //     number: 8379813263,
  //     fromDate: DateTime(11, 06, 2023),
  //     toDate: DateTime(12, 7, 2023),
  //   ),
  //   Customer(
  //     name: 'Kishori',
  //     number: 8379813263,
  //     fromDate: DateTime(11, 06, 2023),
  //     toDate: DateTime(12, 7, 2023),
  //   ),
  // ];
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
  // void onQRViewcreated(QRViewController controller) {
  //   setState(() {
  //     this.controller = controller;
  //     controller.scannedDataStream.listen((scanData) {
  //       print('scanData');
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        actions: [
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
                  // Expanded(
                  //   child: QRView(
                  //     key: qrKey,
                  //     onQRViewCreated: onQRViewcreated,
                  //   ),
                  // ),
                  Flexible(
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          // scanQRCode();
                          // setState(() {
                          //   scanEnabled = !scanEnabled;
                          //   controller?.toggleFlash();
                          // });
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
              // Container(
              //     child: ListView.builder(
              //         shrinkWrap: true,
              //         physics: NeverScrollableScrollPhysics(),
              //         itemCount: customers.length,
              //         itemBuilder: (context, index) {
              //           final customer = customers[index];
              //           return Padding(
              //             padding: const EdgeInsets.all(5),
              //             child: Container(
              //               decoration: ShapeDecoration(
              //                 shape: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                   borderSide: BorderSide(color: Colors.grey),
              //                 ),
              //               ),
              //               child: ListTile(
              //                 title: Text(customers[index]['name']),
              //                 subtitle: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         Text(
              //                             'Contact Number: ${customers[index]['number']}'),
              //                         SizedBox(
              //                           width: 15,
              //                         ),
              //                         CircleAvatar(
              //                           radius: 10,
              //                           backgroundColor: Colors.blue,
              //                           child: Icon(
              //                             Icons.phone,
              //                             color: Colors.white,
              //                             size: 15,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     Text(
              //                         'From Date: ${customers[index]['fromDate']}'),
              //                     Text(
              //                         'To Date: ${customers[index]['toDate']}'),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           );
              //         })),
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
                                              text: customers[index]['number'],
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
                                          openDialPad();
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
              // Container(
              //     child: ListView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: customers.length,
              //         itemBuilder: (context, index) {
              //           final customer = customers[index];
              //           return Padding(
              //             padding: const EdgeInsets.all(5),
              //             child: Container(
              //               decoration: ShapeDecoration(
              //                 shape: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10),
              //                   borderSide:
              //                       const BorderSide(color: Colors.grey),
              //                 ),
              //               ),
              //               child: ListTile(
              //                 title: Row(
              //                   children: [
              //                     RichText(
              //                       text: TextSpan(
              //                         style: DefaultTextStyle.of(context).style,
              //                         children: [
              //                           TextSpan(
              //                               text: customers[index]['name'],
              //                               style: const TextStyle(
              //                                   fontSize: 16,
              //                                   fontWeight: FontWeight.bold,
              //                                   color: Colors.black)),
              //                           const TextSpan(text: '\n'),
              //                           const TextSpan(
              //                             text: 'Contact Number: ',
              //                             style: TextStyle(
              //                                 fontSize: 15, color: Colors.black),
              //                           ),
              //                           TextSpan(
              //                             text: customers[index]['number'],
              //                             style: const TextStyle(
              //                                 fontSize: 15, color: Colors.black),
              //                           ),
              //                           const TextSpan(text: '\n'),
              //                           const TextSpan(
              //                             text: 'From Date: ',
              //                             style: TextStyle(
              //                                 fontSize: 15, color: Colors.black),
              //                           ),
              //                           TextSpan(
              //                             text: customers[index]['fromDate'],
              //                             style: const TextStyle(
              //                                 fontSize: 15, color: Colors.black87),
              //                           ),
              //                           const TextSpan(text: '\n'),
              //                           const TextSpan(
              //                             text: 'To Date: ',
              //                             style: TextStyle(
              //                                 fontSize: 15, color: Colors.black),
              //                           ),
              //                           TextSpan(
              //                             text: customers[index]['toDate'],
              //                             style: const TextStyle(
              //                                 fontSize: 15, color: Colors.black87),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           );
              //         })),

              // Container(
              //   child: ListView(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     children: [
              //       ListTile(
              //         title: Text('Customer Name'),
              //       ),
              //       ListTile(
              //         title: Text('Contact Number'),
              //       ),
              //       ListTile(
              //         title: Text('From Date'),
              //       ),
              //       ListTile(
              //         title: Text('To Date'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void openDialPad() async {
    const phoneNumber = 'tel://';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // void scanQRCode() async {
  //   try {
  //     final qrCode = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancle', true, ScanMode.BARCODE);
  //     if (!mounted) return;
  //     setState(() {
  //       getResult = qrCode;
  //     });
  //     print("QRCode_Result:--");
  //     print(qrCode);
  //   } on PlatformException {
  //     getResult = 'Failed to scan QR Code.';
  //   }
  // }
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
// oid onQRViewCreated(QRViewController controller) {
//   this.controller = controller;
//   controller.scannedDataStream.listen((scanData) {
//     if(scanData.code == "" || scanData.code == null){
//
//     }
//     else{
//       controller.pauseCamera();
//       controller.stopCamera();
//       result = scanData;
//       scanBarcode = result!.code!;
//       print("result!.code");
//       print(result!.code);
//     }
//
//     update();
//   });
// }

// void onPermissionSet(BuildContext context, QRViewCont
