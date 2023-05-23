import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/helpers/user_apis.dart';
import '../models/temp_receipt_model.dart';
import '../models/user_model.dart';

Future<bool> connectCart(
    {required BuildContext context, required String uid, required UserModel? user}) async {
  Future<bool> result = Future.value(false);
    String? userID = user?.userId;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    prefs.setString("uid", uid);

    print(userID);
    var reqBody = {"UID": uid, "userID": userID};
    http.Response res =
        await http.post(Uri.parse("http://3.106.170.176:3000/addTempReceipt"),
            headers: {
              "Content-type": "application/json",
              "Authorization": "Bearer $accessToken",
            },
            body: jsonEncode(reqBody));

    if (res.statusCode == 204) {
      result = Future.value(true);
      prefs.setBool("result", true);
    } else{
      showSnackBar(context, jsonDecode(res.body)['message']);
      result = Future.value(false);
      prefs.setBool("result", false);
    }

    return result;
}

Future<TempReceiptModel?> getTempReceipt({
  required UserModel? user,
}) async {
  TempReceiptModel? tempReceipt;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.userId;

    http.Response res = await http.get(
      Uri.parse("http://3.106.170.176:3000/getTempReceipt/$userID"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> Receipt = jsonDecode(res.body);
      tempReceipt = TempReceiptModel.fromJson(Receipt);
    }
    else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    return tempReceipt;

}

Future<List<num>?> compareWeight({
  required UserModel? user,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accesstoken');
  String? userID = user?.userId;

  http.Response res = await http.get(
    Uri.parse("http://3.106.170.176:3000/compareWeights/$userID"),
    headers: {
      "Authorization": "Bearer $accessToken",
    },
  );

  if (res.statusCode == 200) {
    if (jsonDecode(res.body)['message'] == "Weights match") {

    }
  }
  else if (res.statusCode == 409) {

    var jsonResponse = jsonDecode(res.body);
    List<num> weights=[jsonResponse['tempweight'],jsonResponse['totalweight']];

    return weights;

  }
    else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    //return tempReceipt;
    // } catch (err) {
    //   print("GET TEMP RECEIPT CATCH BLOCK printting temp receipt uid ofc its null");
    //   print(tempReceipt?.uid);
    //   print(err);
    //   return tempReceipt;
    // }

}
Future<void> increaseQuantity(
    {UserModel? user,
    required String? productBarcode,
    required int? productQuantity}) async {
  //try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.userId;
    var reqBody = {
      "productBarcode": productBarcode,
      "increaseProductQuantity": productQuantity
    };

    http.Response res = await http.put(
        Uri.parse("http://3.106.170.176:3000/increaseQuantity/$userID"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(reqBody));

    if(res.statusCode != 204)
      {
        Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
      }
  // } catch (err) {
  //   print(err);
  //   print("INSIDE CATCH BLOCK OF INCREASE QTY");
  // }
}

Future<void> decreaseQuantity(
    {UserModel? user,
    required String? productBarcode,
    required int? productQuantity}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.userId;
    var reqBody = {
      "productBarcode": productBarcode,
      "removeProductQuantity": productQuantity
    };
    http.Response res = await http.put(
        Uri.parse("http://3.106.170.176:3000/decreaseQuantity/$userID"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(reqBody));

    print("AFTER HTTP CALL INCREASE QTY STATUS CODE IS!!!!!!!!!!!!!!!1!!!!");
    print(res.statusCode);
  } catch (err) {
    print(err);
    print("INSIDE CATCH BLOCK OF DECREASE QTY");
  }
}


Future<void> addItem(
    {required UserModel? user,
    required String productBarcode,
    required num? productQuantity}) async {
  //try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    print("assigning userid");
    String? userID = user?.userId;

    print("user ID is:");
    print(userID);
    var reqBody = {
      "productBarcode": productBarcode,
      "productQuantity": productQuantity
    };
    http.Response res = await http.put(
        Uri.parse("http://3.106.170.176:3000/addItemToCart/$userID"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(reqBody));

    print("AFTER HTTP CALL ADD ITEM STATUS CODE IS!!!!!!!!!!!!!!!1!!!!");
    print(res.statusCode);

    if(res.statusCode != 204)
      {
        Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
      }
  // } catch (err) {
  //   print(err);
  //   print("INSIDE CATCH BLOCK OF ADDITEM");
  // }
}


Future<bool> isConnected({
  required UserModel? user,
}) async {
  Future<bool> result = Future.value(false);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accesstoken');
  String? userID = user?.userId;

  http.Response res = await http.get(
    Uri.parse("http://3.106.170.176:3000/getTempReceipt/$userID"),
    headers: {
      "Authorization": "Bearer $accessToken",
    },
  );

  if (res.statusCode == 200) {
    result = Future.value(true);
  }

  return result;

}


Future<void> RemoveTempReciept(
    {UserModel? user}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.userId;
    String? uid = prefs.getString('uid');
    var reqBody = {
      "userID": userID,
      "UID": uid
    };

    http.Response res = await http.put(
        Uri.parse("http://3.106.170.176:3000/removeTempReciept"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(reqBody));


    if(res.statusCode != 204)
    {
      Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
    }
    else{
      prefs.remove('uid');
    }


}