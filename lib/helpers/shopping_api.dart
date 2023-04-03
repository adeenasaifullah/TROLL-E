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


Future<ItemModel?> getAllProducts() async{
  ItemModel? products;
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accesstoken');

    http.Response res =
    await http.get(Uri.parse("http://10.0.2.2:3000/allProducts"),
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
    await http.get(Uri.parse("http://10.0.2.2:3000/getTempReceipt/$userID"),
        headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},

    );

    print("GET TEMP RECEIPT RES.STATUS CODE IS");
    print(res.statusCode);
      if(res.statusCode==200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        tempReceipt = ReceiptModel.fromJson(json);
      }
      print("GET TEMP RECEIPT RES.STATUS CODE IS");
      print(res.statusCode);
    return tempReceipt;
  }
  catch(err){
      print("GET TEMP RECEIPT CATCH BLOCK");
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
    await http.put(Uri.parse("http://10.0.2.2:3000/addItemToCart/$userID"),
        headers: { "Content-type": "application/json", "Authorization": "Bearer $accessToken",},
        body: jsonEncode(reqBody)
    );

    print("AFTER HTTP CALL STATUS CODE IS!!!!!!!!!!!!!!!1!!!!");
    print(res.statusCode);

  }
  catch(err){
  print("INSIDE CATCH BLOCK OF ADDITEM");
  }

}
