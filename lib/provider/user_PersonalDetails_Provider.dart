import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../data/user_personalDetails_data_model.dart';

class UserDetailsProvider extends ChangeNotifier {
  // List<UserProfileDataModel>? post;
  // bool loading = false;
  // getPostData() async {
  //   loading = true;
  //   post = (await getUserProfileData());
  //   loading = false;
  //   notifyListeners();
  // }

  UserProfileDataModel? _userProfileDataModel;
  UserProfileDataModel? get userProfileDataModel => _userProfileDataModel;

  Future<bool> updatePersonalDetails(
      UserProfileDataModel updatedDetails) async {
    final url =
        'https://webiipl.in/amritmayamilk/api/UserApiController/profile_update';
    final response = await http.post(Uri.parse(url), body: {
      'name': updatedDetails.userName,
      'contact': updatedDetails.userContact,
      'email': updatedDetails.userEmail,
      'address': updatedDetails.userAddress
    });
    if (response.statusCode == 200) {
      _userProfileDataModel = updatedDetails;
      return true;
    } else {
      return false;
    }
  }
}
