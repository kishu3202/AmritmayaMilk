import 'package:amritmaya_milk/data/dailyNeedList_data_model.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final DialNeedList dialNeed;
  const ProductDetailScreen({required this.dialNeed, Key? key})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          child: Table(
            border: TableBorder.all(),
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                      child: Center(
                          child: Text(
                    'Product Name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
                  TableCell(
                      child: Center(
                          child: Text('Unit',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)))),
                  TableCell(
                      child: Center(
                          child: Text('Quantity',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)))),
                  TableCell(
                      child: Center(
                          child: Text('Rate',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)))),
                ],
              ),
              for (var productDetail in widget.dialNeed.productdetails)
                TableRow(
                  children: [
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: Text(
                          productDetail.productName ?? 'N/A',
                          style: TextStyle(fontSize: 16),
                        ))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: Text(
                          productDetail.unitName ?? "",
                          style: TextStyle(fontSize: 16),
                        ))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: Text(
                          productDetail.qnt ?? '',
                          style: TextStyle(fontSize: 16),
                        ))),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                          child: Text(
                        productDetail.rate ?? '',
                        style: TextStyle(fontSize: 16),
                      )),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
