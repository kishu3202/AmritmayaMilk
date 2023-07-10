import 'dart:developer';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: buildQr(context),
            // child: QRView(
            //   key: qrKey,
            //   onQRViewCreated: onQRViewCreated,
            //   onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
            //   // controller: controller!, onQRViewCreated: (QRViewController ) {  },
            // ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scanned Barcode: ${scanBarcode!}'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormScreen()),
              );
            },
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
