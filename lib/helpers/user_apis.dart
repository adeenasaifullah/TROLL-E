import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    print("initializing userprovider line 86");
   //  final userProvider = Provider.of<UserProvider>(context);
    print("initializing prefs line 87");
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
    print("THIS IS THE JSON RESPONSE USER BODY ................................");
    print(jsonResponse['user']);
   // Future<bool> result = Future.value(false);
    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async{
          print("inside onsucess line 108");
          //SharedPreferences preferences = await SharedPreferences.getInstance();
          // prefs.setString('accesstoken', accessToken);
          // prefs.setString('refreshtoken', refreshToken);
          print("line 115 setCurrentUser");
          userProvider.setCurrentUser(user);
          print("THIS IS THE USER");
          print(user.first_name);
          await userProvider.setSharedPreferences(accessToken, refreshToken);



          // prefs.setString('accesstoken', accessToken);
          // prefs.setString('refreshtoken', refreshToken);
           print("LOGINNNNN userprovider accesstoken !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          print(userProvider.prefs.getString("accesstoken"));

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

    print(" BEFORE SHARED PREF !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    print("TRYING TO PRINT access token  HERE");
    print(accessToken);
    print("TRYING TO PRINT prefs.get(accesstoken) HERE");
    print(prefs.get("accesstoken"));
    http.Response res =
    await http.get(Uri.parse("http://localhost:3000/getprofile"),
      headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},);
    print(" BEFORE HTTP ERROR HANDLE and now res.body!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print((res.body));
    print("^^^^^^^^^^^^^^^^^^^^^^^");
    httpErrorHandle(
        response: res,
        context: context,

        onSuccess: () async{
          print(" BEFORE MAP !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

          //SharedPreferences preferences = await SharedPreferences.getInstance();
          Map<String, dynamic> json = jsonDecode(res.body);
          user = UserModel.fromJson(json);
          print("............USER FIRST NAMEE ...........................................");
          print(user?.first_name);


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

    var reqBody = {
      "email" : email,
    };
    http.Response response = await http.post(Uri.parse('http://localhost:3000/forgotpassword'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type":"application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
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


//
// Future<UserModel?> getProfile({required BuildContext context}) async {
//   UserModel? user;
//   try{
//     final userProvider = Provider.of<UserProvider>(context);
//     print(" BEFORE SHARED PREF !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//     //SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? accessToken = userProvider.prefs.getString('accesstoken');
//     print("TRYING TO PRINT access token  HERE");
//     print(accessToken);
//     print("TRYING TO PRINT prefs.get(accesstoken) HERE");
//     print(userProvider.prefs.get("accesstoken"));
//     http.Response res =
//     await http.get(Uri.parse("http://localhost:3000/getprofile"),
//       headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},);
//     print(" BEFORE HTTP ERROR HANDLE and now res.body!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//     print((res.body));
//     print("^^^^^^^^^^^^^^^^^^^^^^^");
//     httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () async{
//           print(" BEFORE MAP !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//           //SharedPreferences preferences = await SharedPreferences.getInstance();
//           Map<String, dynamic> json = jsonDecode(res.body);
//           user = UserModel.fromJson(json);
//           print("............USER FIRST NAMEE ...........................................");
//           print(user?.first_name);
//
//
//         }
//     );
//   return user;
//   }
//
//   catch(err){
//         print(err);
//         return user;
//
//   }
//
// }
