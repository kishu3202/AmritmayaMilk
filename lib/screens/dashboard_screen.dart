import 'package:amritmaya_milk/provider/userProvider/outstandingAmount_Provider.dart';
import 'package:amritmaya_milk/screens/customer_list_screen.dart';
import 'package:amritmaya_milk/screens/login_screen.dart';
import 'package:amritmaya_milk/screens/scan_screen.dart';
import 'package:amritmaya_milk/userData/bill_screen.dart';
import 'package:amritmaya_milk/userData/changePassword_screen.dart';
import 'package:amritmaya_milk/userData/dailyNeedList_screen.dart';
import 'package:amritmaya_milk/userData/intimation_screen.dart';
import 'package:amritmaya_milk/userData/myQR_screen.dart';
import 'package:amritmaya_milk/userData/notification_screen.dart';
import 'package:amritmaya_milk/userData/personalDetails_screen.dart';
import 'package:amritmaya_milk/userData/product_screen.dart';
import 'package:amritmaya_milk/userData/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/deliveryBoyProvider/auth_Provider.dart';

class DashboardScreen extends StatefulWidget {
  final String customerId;
  final bool isDeliveryBoy;
  const DashboardScreen({
    super.key,
    required this.isDeliveryBoy,
    required this.customerId,
    required userData,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanEnabled = false;
  String selectedMobileNumber = '';
  String customerId = '';

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
      'fromDate': '2/7/2023',
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
      'fromDate': '25/04/2023',
      'toDate': '27/05/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/04/2023',
      'toDate': '27/05/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/04/2023',
      'toDate': '27/05/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/04/2023',
      'toDate': '27/05/2023'
    },
    {
      'name': 'Rahul',
      'number': '7276573202',
      'address': 'Satara',
      'fromDate': '25/04/2023',
      'toDate': '27/05/2023'
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAmount();
    });
  }

  void getAmount() async {
    final outamountProvider =
        Provider.of<OutStandingAmountProvider>(context, listen: false);
    try {
      await outamountProvider.fetchAmount(widget.customerId);
      final outstandingAmount = outamountProvider.outstandingamount;
      final paidAmount = outamountProvider.totalpayamount;
      print("amount id: ${widget.customerId}");
      print('Outstanding Amount: $outstandingAmount');
      print('Paid Amount: $paidAmount');
    } catch (error) {
      print('Error fetching amount: $error');
    }
  }

  Future<void> fetchCustomerID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerId = prefs.getString('id') ?? '';
    });
    print('customer id for user: ${customerId}');
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final amountProvider =
        Provider.of<OutStandingAmountProvider>(context, listen: true);
    String appBarTitle = "Dashboard";
    bool showNotificationIcon = false;
    bool isDeliveryBoy = false;
    bool isUser = false;

    if (widget.isDeliveryBoy) {
      appBarTitle = "Delivery Boy Dashboard";
      isDeliveryBoy = true;
    } else {
      appBarTitle = "Dashborad";
      showNotificationIcon = true;
      isUser = true;
    }

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
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => MultipleProductScreen()));
          //   },
          //   icon: const Icon(Icons.add),
          //   color: Colors.white,
          // ),

          centerTitle: true,
          title: Text(appBarTitle),
          // title: const Text('Dashboard'),
          automaticallyImplyLeading: false,
          actions: [
            if (showNotificationIcon)
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen(
                                customerId: widget.customerId,
                              )));
                },
                icon: const Icon(Icons.notifications),
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDeliveryBoy)
                    Flexible(
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
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
                  if (isDeliveryBoy)
                    const SizedBox(
                      width: 16,
                    ),
                  if (isDeliveryBoy)
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
              if (isDeliveryBoy)
                const SizedBox(
                  height: 20,
                ),
              if (isDeliveryBoy)
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
              if (isDeliveryBoy)
                const SizedBox(
                  height: 20,
                ),
              if (isDeliveryBoy)
                Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          // final customer = customers[index];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              decoration: ShapeDecoration(
                                color: Colors.deepPurple.shade50,
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
              if (isUser)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "Outstanding Amount",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: Text(
                                "${amountProvider.outstandingamount ?? "N/A"}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "Paid Amount",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: Text(
                                "${amountProvider.totalpayamount ?? "N/A"}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              SizedBox(
                height: 40,
              ),
              if (isUser)
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ScrollLoopAutoScroll(
                        child: Text(
                          "Payment of Milk should not be paid to the delivery staff (दूध का पैसा डिलीवरी स्टाफ को देना मना).",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        scrollDirection: Axis.horizontal,
                        delay: Duration(seconds: 1),
                        duration: Duration(seconds: 50),
                        gap: 25,
                        reverseScroll: false,
                        duplicateChild: 25,
                        enableScrollInput: true,
                        delayAfterScrollInput: Duration(seconds: 1)),
                  ),
                ),
              if (isUser)
                SizedBox(
                  height: 40,
                ),
              if (isUser)
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 100,
                  ),
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BillScreen(
                                        customerId: widget.customerId,
                                      )));
                        },
                        child: Text(
                          "Bill",
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DailyNeedListScreen(
                                        customerId: widget.customerId,
                                      )));
                        },
                        child: Text(
                          "Daily Need List",
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IntimationScreen(
                                        customerId: widget.customerId,
                                      )));
                        },
                        child: Text(
                          "Intimation",
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyQRScreen()));
                        },
                        child: Text(
                          "My QR",
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen()));
                        },
                        child: Text(
                          "Products",
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupportScreen()));
                        },
                        child: Text(
                          "Support",
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalDetails()));
                        },
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen(
                                        customerId: widget.customerId,
                                      )));
                        },
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                          ),
                        )),
                  ],
                ),
            ],
          )),
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
              Provider.of<AuthProvider>(context, listen: false).logout(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
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
