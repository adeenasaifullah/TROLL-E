import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Item_model.dart';
import '../models/temp_receipt_model.dart';
import '../models/user_model.dart';

Future<bool> connectCart(
    {required String uid, required UserModel? user}) async {
  Future<bool> result = Future.value(false);
  try {
    String? userID = user?.userId;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    print("ACCESS TOKEN INITIALIZED");
    var reqBody = {"UID": uid, "userID": userID};
    http.Response res =
        await http.post(Uri.parse("http:/localhost:3000/addTempReceipt"),
            headers: {
              "Content-type": "application/json",
              "Authorization": "Bearer $accessToken",
            },
            body: jsonEncode(reqBody));

    if (res.statusCode == 204) {
      result = Future.value(true);
    } else {
      result = Future.value(false);
    }
    return result;
  } catch (err) {
    return result;
  }
}

Future<ItemModel?> getAllProducts() async {
  ItemModel? products;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');

    http.Response res = await http.get(
      Uri.parse("http://3.106.170.176:3000/allProducts"),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    print("GET ALL PRODUCT RES.STATUS CODE IS");
    print(res.statusCode);
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      products = ItemModel.fromJson(json);
    }

    return products;
  } catch (err) {
    print("GET ALL PRODUCT CATCH BLOCK");
    return products;
  }
}

Future<TempReceiptModel?> getTempReceipt({
  required UserModel? user,
}) async {
  TempReceiptModel? tempReceipt;
  try {
    // print(tempReceipt.)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.userId;

    print("user ID is:");
    print(userID);
    print(accessToken);
    http.Response res = await http.get(
      Uri.parse("http://3.106.170.176:3000/getTempReceipt/$userID"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    print("GET TEMP RECEIPT RES.STATUS CODE IS");
    print(res.statusCode);

    print("RES.BODY IS:");
    print(res.body);

    if (res.statusCode == 200) {
      Map<String, dynamic> Receipt = jsonDecode(res.body);
      print("NOW IM PRINTING JSON IN 200 STATUS CODE");
      //print(json);
      tempReceipt = TempReceiptModel.fromJson(Receipt);
      print("NOW PRINT TEMP RECEIPT");
      print(tempReceipt.receipt.items[0].grossTotal);
      print("PRINT TEMPRECEIPT?.ITEMS");
      print("PRINT TOTALWEIGHTTTTTTT");
      print(tempReceipt?.receipt.totalWeight);

      //print(tempReceipt?.receipt.totalWeight);
    }
    print("RES.BODY IS:");
    print(res.body);

    return tempReceipt;
  } catch (err) {
    print("GET TEMP RECEIPT CATCH BLOCK");
    return tempReceipt;
  }
}

Future<void> increaseQuantity(
    {UserModel? user,
    required String productBarcode,
    required num? productQuantity}) async {
  try {
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

    print("AFTER HTTP CALL INCREASE QTY STATUS CODE IS!!!!!!!!!!!!!!!1!!!!");
    print(res.statusCode);
  } catch (err) {
    print("INSIDE CATCH BLOCK OF INCREASE QTY");
  }
}

Future<void> decreaseQuantity(
    {UserModel? user,
    required String productBarcode,
    required num? productQuantity}) async {
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
    print("INSIDE CATCH BLOCK OF DECREASE QTY");
  }
}

Future<void> addItem(
    {required UserModel? user,
    required String productBarcode,
    required num? productQuantity}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
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
  } catch (err) {
    print("INSIDE CATCH BLOCK OF ADDITEM");
  }
}
