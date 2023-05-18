import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/helpers/user_apis.dart';
import 'package:troll_e/models/Item_model.dart';
import 'package:troll_e/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  bool isLoading = true;

  Future<void> loginUser({required BuildContext context,
    required String email,
    required String password,}) async {
    isLoading = true;
    await login(context: context, email: email, password: password);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> SignupUser({
    required BuildContext context,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    File? imagefile,
    required String phoneNumber, }) async {
    isLoading=true;
   bool result= await signUp(
        context: context,
        firstName: firstName,
        imagefile: imagefile,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password);
    isLoading=false;
    notifyListeners();
    return result;
  }
}

// class UserProvider extends ChangeNotifier {
//   late SharedPreferences prefs;
//
//   //SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
//   UserModel? user;
//   List<ItemModel> currentShoppingCart = [];
//   List<ItemModel> allProducts = [];
//   bool isLoading = false;
//
//   Future<void> setSharedPreferences(
//       String accessToken, String refreshToken) async {
//     prefs = await SharedPreferences.getInstance();
//     prefs.setString('accesstoken', accessToken);
//     prefs.setString("refreshtoken", refreshToken);
//     notifyListeners();
//   }
//
//   void setCurrentUser(UserModel user) {
//     user = user;
//     isLoading = false;
//     notifyListeners();
//     isLoading = true;
//   }
//}
