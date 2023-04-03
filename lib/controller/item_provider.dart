
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:troll_e/models/Item_model.dart';


class ItemProvider extends ChangeNotifier{
  List<ItemModel>? itemlist=[];
  ReceiptModel? tempReceipt ;
  bool isLoading=false;


  //2NS ATTEMPT
  Future<List<ItemModel>?> getReceipt({UserModel? user}) async{
    isLoading=true;
    tempReceipt=  await getTempReceipt(user: user) ;
     itemlist = await tempReceipt?.items;
     isLoading=false;
    notifyListeners();
    return itemlist;

  }

//1ST ATTEMPT
  // UnmodifiableListView<ItemModel> get items {
  //   return UnmodifiableListView(itemlist);
  // }
  //
  // Future<void> initialReceipt({UserModel? user}) async{
  //   tempReceipt=  await getTempReceipt(user: user) ;
  //   itemlist = await tempReceipt?.items;
  // }
  //
  // Future<void> getReceipt({UserModel? user}) async {
  //   isLoading=true;
  //   await initialReceipt(user: user);
  //   isLoading=false;
  //   notifyListeners();
  // }

  Future<void> addItemToTemp({
    required UserModel? user,
    required String barcode,}) async {
    isLoading=true;
    for (final item in itemlist!) {
      if (item.barcode == barcode) {
        //secondScan();
        break;
      }
      else{
        await addItem(user: user, productBarcode: barcode, productQuantity: 1);
      }
    }
    print("item provider after calling add item");
  //  await getReceipt(user: user);
    notifyListeners();
    isLoading=false;

  }
  void totalweight(){
    //calculate the total weight of all the items
   }

   void total(){
    // calculate the total amount of all the items
   }
}