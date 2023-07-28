import 'package:amritmaya_milk/data/productList_data_model.dart';
import 'package:amritmaya_milk/dataLoad/load_ProductList.dart';
import 'package:flutter/cupertino.dart';

class ProductListProvider extends ChangeNotifier {
  List<ProductList>? post;
  bool loading = false;

  getPostData() async {
    loading = true;
    post = (await getProductList());
    loading = false;
    notifyListeners();
  }
}
