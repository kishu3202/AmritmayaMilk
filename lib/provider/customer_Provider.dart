import 'package:flutter/foundation.dart';

import '../data/data_model.dart';
import '../data/loading_customer_data.dart';

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
