
import 'package:flutter/cupertino.dart';
import 'package:troll_e/models/user_model.dart';
import '../helpers/shopping_api.dart';


class ShoppingProvider extends ChangeNotifier {
  bool result=false;
  bool isLoading = true;

  Future<void> connect(String uid, UserModel? user) async {
    result = await  connectCart(UID: uid,user: user);
    print("the result in provider is");
    print(result);

    isLoading=false;
    notifyListeners();
    isLoading=true;
  }
}