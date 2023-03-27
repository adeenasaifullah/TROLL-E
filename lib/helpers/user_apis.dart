import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../models/receipt_model.dart';


void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context,('an unexpected error occured'));
  }
}
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<bool> signUp({
  required BuildContext context,
  required String email,
  required String first_name,
  required String last_name,
  required String password,
  required String phone_number,
}) async {
    try{
      UserModel newuser =
      UserModel(email: email, first_name: first_name, last_name:
      last_name, password: password, phone_number: phone_number,
          );

    http.Response response = await http.post(Uri.parse('http://localhost:3000/register'),
        body: jsonEncode(newuser),
        headers: {"Content-Type":"application/json"},
    );
      Future<bool> result = Future.value(false);

    httpErrorHandle(
      response: response,
      context: context,
      onSuccess: (){
        showSnackBar(
          context,
          'You have successfully signed up!'
        );
        result = Future.value(true);
      }
    );
      return result;
  }

  catch (error){
    showSnackBar(context, error.toString());
    return Future.value(false);
  }
}


Future<bool> login({
  required BuildContext context,
  required String email,
  required String password,
  required SharedPreferences prefs,

}) async {
  try{
    var reqBody = {
      "email" : email,
      "password" : password
    };
    http.Response response = await http.post(Uri.parse('http://localhost:3000/login'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type":"application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    var accessToken = jsonResponse['accesstoken'];
    var refreshToken = jsonResponse['refreshtoken'];
    Future<bool> result = Future.value(false);
    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async{
          //SharedPreferences preferences = await SharedPreferences.getInstance();
          prefs.setString('accesstoken', accessToken);
          prefs.setString('refreshtoken', refreshToken);


          showSnackBar(
              context,
              'You have successfully logged In!'

          );
          result = Future.value(true);
        }
    );
    return result;
  }catch (error){
    showSnackBar(context, error.toString());
    return Future.value(false);
  }
}
