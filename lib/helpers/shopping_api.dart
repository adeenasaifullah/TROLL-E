import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Item_model.dart';
import '../models/receipt_model.dart';
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
    print("ACCESS TOKEN INITIALIZED");
    var reqBody = {
      "UID": UID,
      "userID": userID
    };
    http.Response res =
    await http.post(Uri.parse("https://troll-e-backend-8bwb.vercel.app/addTempReceipt"),
        headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},
        body: jsonEncode(reqBody)
    );

    if(res.statusCode ==204) {
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


Future<ItemModel?> getAllProducts() async{
  ItemModel? products;
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');

    http.Response res =
    await http.get(Uri.parse("https://troll-e-backend-8bwb.vercel.app/allProducts"),
      headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},

    );

    print("GET ALL PRODUCT RES.STATUS CODE IS");
    print(res.statusCode);
    if(res.statusCode==200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      products = ItemModel.fromJson(json);
    }

    return products;
  }
  catch(err){
    print("GET ALL PRODUCT CATCH BLOCK");
  }
}

Future<ReceiptModel?> getTempReceipt({
  required UserModel? user,
}) async{
  ReceiptModel? tempReceipt;
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.user_id;

    print("user ID is:");
    print(userID);
    http.Response res =
    await http.get(Uri.parse("https://troll-e-backend-8bwb.vercel.app/getTempReceipt/$userID"),
        headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},

    );

    print("GET TEMP RECEIPT RES.STATUS CODE IS");
    print(res.statusCode);

    print("RES.BODY IS:");
    print(res.body);

      if(res.statusCode==200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        print("NOW IM PRINTING JSON IN 200 STATUS CODE");
        print(json);
        tempReceipt = ReceiptModel.fromJson(json);
        print("NOW PRINT TEMP RECEIPT");
          print(tempReceipt);
      }
      print("RES.BODY IS:");
      print(res.body);
      print("PRINT TEMPRECEIPT?.ITEMS");
      print(tempReceipt?.items);
    return tempReceipt;
  }
  catch(err){
      print("GET TEMP RECEIPT CATCH BLOCK");
  }
}

Future<void> increaseQuantity({
  UserModel? user,
  required String productBarcode,
  required num? productQuantity
}) async{
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.user_id;
    var reqBody = {
      "productBarcode": productBarcode,
      "increaseProductQuantity": productQuantity
    };
    http.Response res =
    await http.put(Uri.parse("https://troll-e-backend-8bwb.vercel.app/increaseQuantity/$userID"),
        headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},
        body: jsonEncode(reqBody)
    );

    print("AFTER HTTP CALL INCREASE QTY STATUS CODE IS!!!!!!!!!!!!!!!1!!!!");
    print(res.statusCode);


  }catch(err){
    print("INSIDE CATCH BLOCK OF INCREASE QTY");
  }
}


Future<void> decreaseQuantity({
  UserModel? user,
  required String productBarcode,
  required num? productQuantity
}) async{
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.user_id;
    var reqBody = {
      "productBarcode": productBarcode,
      "removeProductQuantity": productQuantity
    };
    http.Response res =
    await http.put(Uri.parse("https://troll-e-backend-8bwb.vercel.app/decreaseQuantity/$userID"),
        headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},
        body: jsonEncode(reqBody)
    );

    print("AFTER HTTP CALL INCREASE QTY STATUS CODE IS!!!!!!!!!!!!!!!1!!!!");
    print(res.statusCode);


  }catch(err){
    print("INSIDE CATCH BLOCK OF DECREASE QTY");

  }
}


Future<void> addItem({
  required UserModel? user,
  required String productBarcode,
  required num? productQuantity
}) async {
  try {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');
    String? userID = user?.user_id;

    print("user ID is:");
    print(userID);
    var reqBody = {
      "productBarcode": productBarcode,
      "productQuantity": productQuantity
    };
    http.Response res =
    await http.put(Uri.parse("https://troll-e-backend-8bwb.vercel.app/addItemToCart/$userID"),
        headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},
        body: jsonEncode(reqBody)
    );

    print("AFTER HTTP CALL ADD ITEM STATUS CODE IS!!!!!!!!!!!!!!!1!!!!");
    print(res.statusCode);

  }
  catch(err){
  print("INSIDE CATCH BLOCK OF ADDITEM");
  }

}
