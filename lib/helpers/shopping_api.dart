import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/helpers/user_apis.dart';
import '../models/Item_model.dart';
import '../models/temp_receipt_model.dart';
import '../models/user_model.dart';

Future<bool> connectCart(
    {required BuildContext context, required String uid, required UserModel? user}) async {
  Future<bool> result = Future.value(false);
  //try {
    String? userID = user?.userId;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');

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
    } else{
      showSnackBar(context, jsonDecode(res.body)['message']);
      result = Future.value(false);
    }

    return result;
  // } catch (err) {
  //   print("Inside catch block of connectcart");
  //   return result;
  // }
}

// Future<ItemModel?> getAllProducts() async {
//   ItemModel? products;
//   //try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? accessToken = prefs.getString('accesstoken');
//
//     http.Response res = await http.get(
//       Uri.parse("http://3.106.170.176:3000/allProducts"),
//       headers: {
//         "Content-type": "application/json",
//         "Authorization": "Bearer $accessToken",
//       },
//     );
//
//     print("GET ALL PRODUCT RES.STATUS CODE IS");
//     print(res.statusCode);
//     if (res.statusCode == 200) {
//       Map<String, dynamic> json = jsonDecode(res.body);
//       products = ItemModel.fromJson(json);
//     }
//     else{
//       Fluttertoast.showToast(
//           msg: jsonDecode(res.body)['message'],
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           textColor: Colors.white,
//           fontSize: 16.0
//       );
//     }
//     return products;
//   // } catch (err) {
//   //   print("GET ALL PRODUCT CATCH BLOCK");
//   //   return products;
//   // }
// }

Future<TempReceiptModel?> getTempReceipt({
  required UserModel? user,
}) async {
  TempReceiptModel? tempReceipt;
  //try {
    // print(tempReceipt.)
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