import 'package:flutter/cupertino.dart';
import 'package:troll_e/models/user_model.dart';
import '../helpers/shopping_api.dart';

class ShoppingProvider extends ChangeNotifier {
  bool result = false;
  bool isLoading = true;
 // bool connected=false;

  Future<void> connect(String uid, UserModel? user) async {
    result = await connectCart(uid: uid, user: user);
    print("rresult in connect of shopping provider");
    print(result);
    isLoading = false;
    notifyListeners();
    isLoading = true;
  }

  Future<void> disconnect() async {

  }
}
