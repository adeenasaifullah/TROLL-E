import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/controller/profile_provider.dart';

import '../helpers/user_apis.dart';
import '../models/shopping_history.dart';
import '../models/user_model.dart';

class HistoryProvider extends ChangeNotifier {
  ShoppingHistoryModel? history;
  bool isLoading = false;

  //2NS ATTEMPT
  Future<void> getHistoryProvider({UserModel? user}) async {
    isLoading = true;
    print("INSIDE PROVIDER OF HISTORY");
    history = await getHistory(user: user);
    isLoading = false;

    notifyListeners();
  }
}