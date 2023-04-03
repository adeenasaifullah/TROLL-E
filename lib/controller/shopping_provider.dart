
import 'package:flutter/cupertino.dart';
import 'package:troll_e/models/user_model.dart';
import '../helpers/shopping_api.dart';


class ShoppingProvider extends ChangeNotifier {
  bool result=false;
  bool isLoading = true;

  void connect(String uid, UserModel? user) {
    result =  connectCart(UID: uid,user: user) as bool;
    isLoading=false;
    notifyListeners();
    isLoading=true;
  }
}