



import 'package:flutter/cupertino.dart';

import '../helpers/user_apis.dart';
import '../models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? userModel;
  bool isChanged = false;
  bool isLoading = true;

  void getUserProfile({required BuildContext context}) async {
    print("INSIDE PROVIDER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    userModel=await getProfile(context: context);
    isLoading=false;
    notifyListeners();
    //isLoading=true;

  }
}