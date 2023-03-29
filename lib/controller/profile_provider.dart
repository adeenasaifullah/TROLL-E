



import 'package:flutter/cupertino.dart';

import '../helpers/user_apis.dart';
import '../models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? user;
  bool isChanged = false;
  bool isLoading = true;

  void getUserProfile({required BuildContext context}) async {
    print("INSIDE PROVIDER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    user=await getProfile(context: context);
    isLoading=false;
    notifyListeners();
    //isLoading=true;

  }
}