import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/helpers/user_apis.dart';
import 'package:troll_e/models/Item_model.dart';
import 'package:troll_e/models/user_model.dart';

class UserProvider extends ChangeNotifier{
  late SharedPreferences prefs;
  //SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
   UserModel? user;
  List<ItemModel> currentShoppingCart = [];
  List<ItemModel> allProducts = [];
  bool isLoading=false;



  Future<void> setSharedPreferences(String accesstoken,String refreshtoken) async {

    prefs =  await SharedPreferences.getInstance();
    prefs.setString('accesstoken', accesstoken);
    prefs.setString("refreshtoken", refreshtoken);
    notifyListeners();
  }

  void setCurrentUser(UserModel User)  {
    user = User;
    isLoading=false;
    notifyListeners();
    isLoading=true;
  }


}