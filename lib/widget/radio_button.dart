import 'package:flutter/material.dart';

enum ProductTypeEnum { one, two, three, four }

class RadioButton extends StatelessWidget {
  const RadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body:   Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Expanded(
        //       child: RadioListTile<ProductTypeEnum>(
        //           title: Text('Polythene charges (Small)'),
        //           contentPadding: EdgeInsets.all(0.0),
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(5.0)),
        //           value: ProductTypeEnum.one,
        //           groupValue: _productTypeEnum,
        //           dense: true,
        //           tileColor: Colors.deepPurple.shade50,
        //           onChanged: (value) {
        //             setState(() {
        //               _productTypeEnum = value;
        //             });
        //           }),
        //     ),
        //     SizedBox(
        //       width: 5.0,
        //     ),
        //     Expanded(
        //       child: RadioListTile<ProductTypeEnum>(
        //           title: Text('Polythene charges (Big)'),
        //           value: ProductTypeEnum.two,
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(5.0)),
        //           groupValue: _productTypeEnum,
        //           dense: true,
        //           tileColor: Colors.deepPurple.shade50,
        //           onChanged: (value) {
        //             setState(() {
        //               _productTypeEnum = value;
        //             });
        //           }),
        //     ),
        //   ],
        // ),
        //   SizedBox(
        //     height: 16,
        //   ),
        //   Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Expanded(
        //         child: RadioListTile<ProductTypeEnum>(
        //             title: Text('Delivery Charges'),
        //             contentPadding: EdgeInsets.all(0.0),
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(5.0)),
        //             value: ProductTypeEnum.three,
        //             groupValue: _productTypeEnum,
        //             dense: true,
        //             tileColor: Colors.deepPurple.shade50,
        //             onChanged: (value) {
        //               setState(() {
        //                 _productTypeEnum = value;
        //               });
        //             }),
        //       ),
        //       SizedBox(
        //         width: 5.0,
        //       ),
        //       Expanded(
        //         child: RadioListTile<ProductTypeEnum>(
        //             title: Text('Maintenance Charges'),
        //             value: ProductTypeEnum.four,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(5.0)),
        //             groupValue: _productTypeEnum,
        //             dense: true,
        //             tileColor: Colors.deepPurple.shade50,
        //             onChanged: (value) {
        //               setState(() {
        //                 _productTypeEnum = value;
        //               });
        //             }),
        //       ),
        //     ],
        //   ),,
        );
  }
}
