
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:troll_e/models/Item_model.dart';
import 'package:troll_e/models/receipt_model.dart';

import '../helpers/shopping_api.dart';
import '../models/user_model.dart';

class ItemProvider extends ChangeNotifier{
  late List<ItemModel> itemlist;
  ReceiptModel? receiptModel ;
  bool isLoading=false;

  // UnmodifiableListView<ItemModel> get items {
  //   return UnmodifiableListView(itemlist);
  // }

  Future<void> getReceipt({UserModel? user}) async {
    isLoading=true;
    receiptModel=  await getTempReceipt(user: user) ;
    itemlist = (await receiptModel?.items)!;
    isLoading=false;
    notifyListeners();
  }


  void totalweight(){
    //calculate the total weight of all the items
   }

   void total(){
    // calculate the total amount of all the items
   }
}