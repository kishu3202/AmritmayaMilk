import 'package:flutter/cupertino.dart';

import '../../data/deliverBoy_data_model/customerlist_data_model.dart';
import '../../data/deliverBoy_data_model/loading_customerlist_data.dart';

class CustomerProvider extends ChangeNotifier {
  List<DataModel>? post;
  bool loading = false;
  getPostData() async {
    loading = true;
    post = (await getData());
    loading = false;
    notifyListeners();
  }
}
