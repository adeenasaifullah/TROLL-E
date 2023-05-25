import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/user_apis.dart';
import '../models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? user;
  bool isChanged = false;
  bool isLoading = true;
  bool prefsLoading = true;
  String passwordResetToken = '';
  String passwordResetUserid = '';
  bool result = false;


  void getUserProfile({required BuildContext context}) async {
    user = await getProfile(context: context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('result')==null)
      {
        result = false;
      }
    else
      {
        result = prefs.getBool('result')!;
      }

    isLoading = false;
    notifyListeners();
    //isLoading=true;
  }

  void setPasswordResetDetails(
      {required String token, required String userID}) async {
    passwordResetToken = token;
    passwordResetUserid = userID;
    notifyListeners();
  }

   getShoppingHistory(){
    return user?.shoppingHistory;
  }

  void checkPrefsLoading(bool prefsLoading){

    this.prefsLoading = prefsLoading;
    notifyListeners();

  }
}


