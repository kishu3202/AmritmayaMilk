import 'package:flutter/foundation.dart';

import '../data/dailyNeedProduct_data_model.dart';
import '../data/loadingDailyNeedProduct_data.dart';

class DailyNeedProductProvider extends ChangeNotifier {
  List<DialNeedList> dialNeedList = [];
  bool loading = false;

  Future<List<DialNeedList>> getPostDailyNeedProduct(String customerId) async {
    loading = true;
    dialNeedList = await getDailyNeedProductData(customerId);
    loading = false;
    notifyListeners();
    List<DialNeedList> dataList = await getDailyNeedProductData(customerId);
    return dataList;
  }
}
