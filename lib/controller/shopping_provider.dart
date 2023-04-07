import 'package:flutter/cupertino.dart';
import 'package:troll_e/models/user_model.dart';
import '../helpers/shopping_api.dart';

class ShoppingProvider extends ChangeNotifier {
  bool result = false;
  bool isLoading = true;

  Future<void> connect(String uid, UserModel? user) async {
    result = await connectCart(uid: uid, user: user);
    isLoading = false;
    notifyListeners();
    isLoading = true;
  }
}
