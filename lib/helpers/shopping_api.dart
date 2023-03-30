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
    String? userID=user?.user_id;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
        http.Response res =
        await http.post(Uri.parse("http://localhost:3000/addTempReceipt"),
      headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},);

      if(res.statusCode ==200) {
        result = Future.value(true);
      }
      else {

        result = Future.value(false);
      }
      return result;
  }
  catch(err){
      return result;
  }

}

