import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/helpers/user_apis.dart';
import 'package:troll_e/models/Item_model.dart';
import 'package:troll_e/models/user_model.dart';

class UserProvider extends ChangeNotifier{
  late SharedPreferences prefs;
  //SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
  late UserModel? user;
  List<ItemModel> currentShoppingCart = [];
  List<ItemModel> allProducts = [];


  Future<void> setSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future <void> setCurrentUser(UserModel User) async {
    user = User;
    notifyListeners();
  }

}