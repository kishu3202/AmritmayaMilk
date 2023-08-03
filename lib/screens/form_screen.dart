import 'package:amritmaya_milk/provider/dailyNeedProduct_Provider.dart';
import 'package:amritmaya_milk/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  final String customerId;
  const FormScreen({required this.customerId, Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    super.initState();
    fetchCustomerData();
  }

  void fetchCustomerData() async {
    final dailyNeedProvider =
        Provider.of<DailyNeedProductProvider>(context, listen: false);
    await dailyNeedProvider.fetchDailyNeedProduct(widget.customerId);
  }

  // void fetchCustomerData() async {
  //   // Fetch saved data from SharedPreferences
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int selectedOption = prefs.getInt('selected_option') ?? 0;
  //   String mobileNumber = prefs.getString('mobile_number') ?? '';
  //   String scannedBarcode = prefs.getString('scanned_barcode') ?? '';
  //
  //   // Use the saved data to decide which API call to make
  //   if (selectedOption == 1) {
  //     // Make the API call using the mobile number from SharedPreferences
  //     final dailyNeedProvider =
  //         Provider.of<DailyNeedProductProvider>(context, listen: false);
  //     dailyNeedProvider.fetchDailyNeedProduct(widget.customerId);
  //   } else if (selectedOption == 2) {
  //     // Make the API call using the scanned barcode from SharedPreferences
  //     final dailyNeedProvider =
  //         Provider.of<DailyNeedProductProvider>(context, listen: false);
  //     dailyNeedProvider.fetchDailyNeedProduct(widget.customerId);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final dailyNeedProvider =
        Provider.of<DailyNeedProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Need Product List'),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: dailyNeedProvider.fetchDailyNeedProduct(widget.customerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to fetch data.'));
          } else {
            return dailyNeedProvider.customerID.isEmpty
                ? Center(child: Text('No data found.'))
                : ListView.builder(
                    itemCount: dailyNeedProvider.customerID.length,
                    itemBuilder: (context, index) {
                      return CustomerCard(
                        customerName: dailyNeedProvider.customerName[index],
                        createdDate:
                            dailyNeedProvider.customerCreatedDate[index],
                        orderID: dailyNeedProvider.customerOrderID[index],
                        productDetails:
                            dailyNeedProvider.customerProductDetails[index],
                      );
                    },
                  );
          }
        },
      ),
      floatingActionButton: Container(
        height: 60,
        width: 220,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(
                  customerId: widget.customerId,
                ),
              ),
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
    );
  }
}

class CustomerCard extends StatelessWidget {
  final String customerName;
  final String createdDate;
  final String orderID;
  final String productDetails;
  CustomerCard({
    required this.customerName,
    required this.createdDate,
    required this.orderID,
    required this.productDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text("Customer Name: $customerName"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Created Date: $createdDate'),
            Text('Order ID: $orderID'),
            Text('Product Details: $productDetails'),
          ],
        ),
      ),
    );
  }
}
