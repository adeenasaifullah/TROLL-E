import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

Future<bool> connectCart({
  required String UID,
  required UserModel? user
}) async {
  Future<bool> result=Future.value(false);
  try{
    print("TRY BLOCK IN CONNECT CART STARTED in shopping_api and this is the first_name${user?.first_name}");
    String? userID=user?.user_id;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    print("ACCESS TOKEN INITIALIZED");
    var reqBody = {
      "UID": UID,
      "userID": userID
    };
    http.Response res =
    await http.post(Uri.parse("http://10.0.2.2:3000/addTempReceipt"),
        headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},
        body: jsonEncode(reqBody)
    );

    print("AFTER HTTP CALL !!!!!!!!!!!!!!!1!!!!");
    print(res.statusCode);

    if(res.statusCode == 204) {
      result = Future.value(true);
    }
    else {
      result = Future.value(false);
    }

    print("THE RESULT ISSSSSSS " );
    if(result == Future.value(true)){
      print("trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }else {
      print("falseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    }

    return result;
  }
  catch(err){
    return result;
  }


}
