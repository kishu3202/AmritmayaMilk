import 'package:flutter/cupertino.dart';

import '../data/loadingUserProfile_data.dart';
import '../data/userProfileData_model.dart';

class CustomerProvider extends ChangeNotifier {
  List<UserProfileDataModel>? post;
  bool loading = false;
  getPostData() async {
    loading = true;
    post = (await getUserProfileData());
    loading = false;
    notifyListeners();
  }
}
