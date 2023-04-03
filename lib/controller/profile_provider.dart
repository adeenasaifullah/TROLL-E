



import 'package:flutter/cupertino.dart';

import '../helpers/user_apis.dart';
import '../models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? user;
  bool isChanged = false;
  bool isLoading = true;
  String passwordresettoken = '';
  String passwordresetuserid = '';

  void getUserProfile({required BuildContext context}) async {
    user=await getProfile(context: context);
    isLoading=false;
    notifyListeners();
    //isLoading=true;

  }
  void setPasswordResetDetails({required String token, required String userID}) async{
    passwordresettoken = token;
    passwordresetuserid = userID;
    notifyListeners();
  }
}

