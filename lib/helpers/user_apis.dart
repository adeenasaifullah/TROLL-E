import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/controller/profile_provider.dart';
import 'package:troll_e/controller/user_provider.dart';
import 'package:troll_e/models/shopping_history.dart';
import 'package:troll_e/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../models/temp_receipt_model.dart';
import '../views/homescreen/homescreen.dart';
import '../views/login_signup/login.dart';
import '../views/login_signup/login_input_wrapper.dart';

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
      showSnackBar(context, ('an unexpected error occurred'));
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
  required String firstName,
  required String lastName,
  required String password,
  required String phoneNumber,
  File? imagefile,
}) async {
  //try {
    //String imageBase64 = ''; // initialize image data as empty string
    // if (imagefile != null) {
    //   List<int> imageBytes = await imagefile.readAsBytes();
    //   imageBase64 = base64Encode(imageBytes); // convert image to base64 string
    // }

    String img=imagefile.toString();
    String actualpath = img.split("'")[1];

    UserModel newUser = UserModel(
      email: email,
      image: actualpath,
      firstName: firstName,
      lastName: lastName,
      password: password,
      phoneNumber: phoneNumber,
    );

    http.Response response = await http.post(
      Uri.parse('http://3.106.170.176:3000/register'),
      body: jsonEncode(newUser),
      headers: {"Content-Type": "application/json"},
    );

    print(response.body);

    Future<bool> result = Future.value(false);

    if(response.statusCode == 200)
      {
        showSnackBar(context, 'You have successfully signed up!');
        result = Future.value(true);
      }
    else{
      print("REGISTER ELSE STATEMENT");
      showSnackBar(context, "response.body.");
    }
    //
    //
    // httpErrorHandle(
    //     response: response,
    //     context: context,
    //     onSuccess: () {
    //       showSnackBar(context, 'You have successfully signed up!');
    //       result = Future.value(true);
    //     });
    return result;
  // } catch (error) {
  //
  //   //showSnackBar(context, error.toString());
  //   showSnackBar(context, 'bad.');
  //   return Future.value(false);
  // }
}

Future<ShoppingHistoryModel?> getHistory({UserModel? user}) async {
  ShoppingHistoryModel? history;
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');

    print(accessToken);
    String? userID = user?.userId;

    http.Response res = await http.get(
      Uri.parse("http://3.106.170.176:3000/getHistory/$userID"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );
    if (res.statusCode == 200) {

      Map<String, dynamic> Receipt = jsonDecode(res.body);

      //print(json);
      history = ShoppingHistoryModel.fromJson(Receipt);
    }
    return history;

  }
catch(err){

  return history;
}
}

Future<void> login(
    {
      required BuildContext context,
      required String email,
      required String password,}) async {

    var reqBody = {"email": email, "password": password};
    http.Response response = await http.post(
      Uri.parse('http://3.106.170.176:3000/login'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type": "application/json"},
    );

    var jsonResponse = jsonDecode(response.body);

    print("-----------------STATUS CODE----------------");
    print(response.statusCode);
    if (response.statusCode == 200) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = jsonResponse['accesstoken'];
      var refreshToken = jsonResponse['refreshtoken'];
      var userJson = jsonResponse['user'];
      var loginStatus = userJson['loggedin_before'];

      prefs.setString('accesstoken', accessToken);
      prefs.setString("refreshtoken", refreshToken);
      prefs.setBool("loginStatus", loginStatus);

      prefs.setBool("result", false);
      showSnackBar(context, 'Login Successful');
    }
    else{
        showSnackBar(context, jsonResponse['message']);
    }


}

void logout(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("refreshtoken");
    prefs.remove("accesstoken");

    prefs.remove("uid");

  } catch (error) {
    //showSnackBar(context, error.toString());
  }
}

Future<UserModel?> getProfile({required BuildContext context}) async {
  UserModel? user;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    http.Response res = await http.get(
      Uri.parse("http://3.106.170.176:3000/getprofile"),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );
    httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
           Map<String, dynamic> json = jsonDecode(res.body);
           print("printing json body from getprofile api ${json}");
          if(json['google_id'] != null)
          {
            print("${json['google_id']} of user ${json['first_name']} ");
            Map<String, dynamic> customuserbody = new Map<String, dynamic>();
            customuserbody = {
              '_id' : json['_id'],
              'email': json['email'],
              'first_name': json['first_name'],
              'last_name': json['last_name'],
              'password': "-",
              'phone_number': "-",
              'shoppingHistory': json['shoppingHistory']
            };
            user = UserModel.fromJson(customuserbody);
          }
          else  user = UserModel.fromJson(json);
        });
    return user;
  } catch (err) {
    print(err);
    return user;
  }
}

Future<void> forgotPassword({
  required BuildContext context,
  required String email,
}) async {
  // SharedPreferences prefs= await SharedPreferences.getInstance();
  try {
    final setToken = Provider.of<ProfileProvider>(context, listen: false);
    var reqBody = {
      "email": email,
    };
    http.Response response = await http.post(
      Uri.parse('http://3.106.170.176:3000/forgotpassword'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type": "application/json"},
    );
    var jsonResponse = jsonDecode(response.body);
    var userID = jsonResponse['userID'];
    var token = jsonResponse['token'];
    setToken.setPasswordResetDetails(token: token, userID: userID);
    //print("this is my token: ${token}");
    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          print("email sent");
          showSnackBar(
              context, 'Change password link has been sent to your email.');
          //result = Future.value(true);
        });

    // return result;
  } catch (error) {
    showSnackBar(context, error.toString());
    //return Future.value(false);
    //return prefs;
  }
}

Future<void> resetPassword({
  required BuildContext context,
  required String resetPassword,
}) async {
  // SharedPreferences prefs= await SharedPreferences.getInstance();
  try {
    final details = Provider.of<ProfileProvider>(context, listen: false);
    var userID = details.passwordResetUserid;
    var token = details.passwordResetToken;
    //ProfileProvider setToken = Provider.of<ProfileProvider>(context);
    var reqBody = {
      "password": resetPassword,
    };

    http.Response response = await http.post(
      Uri.parse('http://3.106.170.176:3000/changepassword/$userID/$token'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type": "application/json"},
    );

    var jsonResponse = jsonDecode(response.body);

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          print("password changed");
          showSnackBar(context, 'Your password has been changed successfully');
          //result = Future.value(true);
        });
    // return result;
  } catch (error) {
    showSnackBar(context, error.toString());
    //return Future.value(false);
    //return prefs;
  }
}

Future<UserModel?> googleLogIn(
    {required BuildContext context,
  required String? email,
      required String? name,
      required String? photourl,
      required String? googleid,
  required UserProvider userProvider}) async {
  try {
    print("inside google log in api");
    // final url = 'http://3.106.170.176:3000/google/login'; // Replace with your backend server URL
    var reqBody = {
      "email": email, "name": name, "photourl": photourl, "googleid": googleid
    };

    http.Response response = await http.post(
      Uri.parse('http://3.106.170.176:3000/google/login'),
      body: jsonEncode(reqBody),
      headers: {"Content-Type": "application/json"},
    );
    print("api called for google");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("response is ok");
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['accesstoken']);
      var accessToken = jsonResponse['accesstoken'];
      print(accessToken);
      var refreshToken = jsonResponse['refreshtoken'];
      var userJson = jsonResponse['user'];
       print("userJson from backend $userJson");
      Map<String, dynamic> customuserbody = new Map<String, dynamic>();
       customuserbody = {
         '_id' : userJson['_id'],
         'email': userJson['email'],
         'first_name': userJson['first_name'],
         'last_name': userJson['last_name'],
         'password': "-",
         'phone_number': "-",
         'shoppingHistory': userJson['shoppingHistory']
  };

       print("custom user body ${customuserbody}");
      UserModel user = UserModel.fromJson(customuserbody);
       print("This is user's email ${user.email}");
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            print("THIS IS ACCESS TOKEN");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('accesstoken', accessToken);
            print(prefs.get('accesstoken'));
            prefs.setString("refreshtoken", refreshToken);
            // await userProvider.setSharedPreferences(accessToken, refreshToken);
          });

      return user;
    }
  }
  catch (error) {
    showSnackBar(context, error.toString());
    //return Future.value(false);
    //return prefs;
  }



  }

