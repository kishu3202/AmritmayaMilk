import 'dart:developer';

import 'package:amritmaya_milk/provider/customerData_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'form_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String scanBarcode = "";
  int selectedOption = 0; // 0: Nothing selected, 1: mobile number, 2: QR code
  TextEditingController mobileNoController = TextEditingController();
  QRViewController? controller;

  @override
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code == "" || scanData.code == null) {
        print("false");
      } else {
        controller.pauseCamera();
        controller.stopCamera();
        var result = scanData;
        print('result!.code');
        print(result.code);
        scanBarcode = result.code!;
      }
    });
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Widget buildQr(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
    );
  }

  void _submitData() {
    if (selectedOption == 1) {
      String mobileNo = mobileNoController.text.trim();
      // check if mobile number is not empty
      if (mobileNo.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Error:',
                style: TextStyle(color: Colors.red),
              ),
              content: const Text('Please enter a valid mobile number.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // navigate to the next screen
        final customerDataProvider =
            Provider.of<CustomerDataProvider>(context, listen: false);
        customerDataProvider.getCustomerData(mobileNo).then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormScreen(),
            ),
          );
          print('Selected Option: With Mobile Number');
          print('Mobile Number: $mobileNo');
        });
      }
    } else if (selectedOption == 2) {
      // check if a QR code has been scanned
      if (scanBarcode.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Error:',
                style: TextStyle(color: Colors.red),
              ),
              content: const Text('Please scan a QR code.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // navigate to the formscreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FormScreen()),
        );
        print('Selected Option: QR Code Scanner');
        print('Scanned Barcode: $scanBarcode');
      }
    } else {
      // show validation error if no option is selected
      showDialog(
          context: context,
          builder: (BuildContext builder) {
            return AlertDialog(
              title: const Text(
                'Error:',
                style: TextStyle(color: Colors.red),
              ),
              content: const Text('Please select an option before submitting.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QR Code Scanner'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
                const Text("With Mobile Number"),
                const SizedBox(
                  width: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      const Text("With QR Scanner"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (selectedOption == 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: mobileNoController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Enter Mobile Number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: (value) {
                  if (selectedOption == 1 && (value == null || value.isEmpty)) {
                    return 'Please enter a valid mobile number';
                  }
                },
              ),
            ),
          if (selectedOption == 2)
            Expanded(
              flex: 5,
              child: buildQr(context),
            ),
          if (selectedOption == 2)
            Expanded(
              flex: 1,
              child: Center(
                child: Text('Scanned Barcode: ${scanBarcode}'),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
