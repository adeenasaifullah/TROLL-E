import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/controller/profile_provider.dart';
import 'package:troll_e/controller/user_provider.dart';
import 'package:troll_e/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../models/receipt_model.dart';
import '../views/login_signup/login.dart';


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
  Future<void> login({
  required BuildContext context,
  required String email,
  required String password,
    required UserProvider userProvider
}) async {
   // SharedPreferences prefs= await SharedPreferences.getInstance();
  try{
  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  //  await userProvider.setSharedPreferences();
    var reqBody = {
      "email" : email,
      "password" : password
    };
    print("making http call line 94");
    http.Response response = await http.post(Uri.parse('http://localhost:3000/login'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type":"application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    var accessToken = jsonResponse['accesstoken'];
    var refreshToken = jsonResponse['refreshtoken'];
    var userJson = jsonResponse['user'];
    UserModel user = UserModel.fromJson(userJson);
   // Future<bool> result = Future.value(false);
    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async{
          userProvider.setCurrentUser(user);

          await userProvider.setSharedPreferences(accessToken, refreshToken);
          //
          // showSnackBar(
          //     context,
          //     'You have successfully logged In!'
          // );
          //result = Future.value(true);
        }
    );
    // return result;
  }catch (error){
    showSnackBar(context, error.toString());
    //return Future.value(false);
    //return prefs;
  }
}


void logout(BuildContext context) async {
  try {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    // var reqBody = {
    //   "refreshtoken": (prefs.get('refreshtoken'))
    // };
    // print(prefs.get('refreshtoken'));
    // http.Response response = await http.delete(Uri.parse('http://localhost:3000/logout'),
    //   body: jsonEncode(reqBody),
    //   headers: {"Content-Type":"application/json"},
    // );

    // httpErrorHandle(
    //     //response: response,
    //     context: context,
    //     onSuccess: () async{
    //       //SharedPreferences preferences = await SharedPreferences.getInstance();
    //       showSnackBar(
    //           context,
    //           'You have successfully logged out!'
    //       );
    //     }
    // );
    prefs.remove("refreshtoken");
    prefs.remove("accesstoken");
    // print("Refresh Token" );
    // print( prefs.getString("refreshtoken"));

  }catch (error){
    //showSnackBar(context, error.toString());
  }
}



Future<UserModel?> getProfile({required BuildContext context}) async {
  UserModel? user;
  try{
print("inside getprofile user api");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    http.Response res =
    await http.get(Uri.parse("http://localhost:3000/getprofile"),
      headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},);
    httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async{
          Map<String, dynamic> json = jsonDecode(res.body);
          user = UserModel.fromJson(json);
        }
    );
    return user;
  }
  catch(err){
    print(err);
    return user;
  }
}

Future<void> forgotpassword({
  required BuildContext context,
  required String email,
}) async {
  // SharedPreferences prefs= await SharedPreferences.getInstance();
  try{
    final setToken = Provider.of<ProfileProvider>(context, listen: false);
    var reqBody = {
      "email" : email,
    };
    http.Response response = await http.post(Uri.parse('http://localhost:3000/forgotpassword'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type":"application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    var userID = jsonResponse['userID'];
    var token = jsonResponse['token'];
    setToken.setPasswordResetDetails(token: token, userID: userID);
    //print("this is my token: ${token}");
    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async{
          print("email sent");
          showSnackBar(
              context,
              'Change password link has been sent to your email.'
          );
          //result = Future.value(true);
        }
    );

    // return result;
  }catch (error){
    showSnackBar(context, error.toString());
    //return Future.value(false);
    //return prefs;
  }
}

Future<void> resetpassword({
  required BuildContext context,
  required String resetpassword,
}) async {
  // SharedPreferences prefs= await SharedPreferences.getInstance();
  try{
    final details = Provider.of<ProfileProvider>(context, listen:false);
    var userID = details.passwordresetuserid;
    var token = details.passwordresettoken;
    //ProfileProvider setToken = Provider.of<ProfileProvider>(context);
    var reqBody = {
      "password" : resetpassword,
    };

    http.Response response = await http.post(Uri.parse('http://localhost:3000/changepassword/${userID}/${token}'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type":"application/json"},
    );

    var jsonResponse = jsonDecode(response.body);


    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async{
          print("password changed");
          showSnackBar(
              context,
              'Your password has been changed successfully'
          );
          //result = Future.value(true);

        }
    );
    // return result;
  }catch (error){
    showSnackBar(context, error.toString());
    //return Future.value(false);
    //return prefs;
  }
}

