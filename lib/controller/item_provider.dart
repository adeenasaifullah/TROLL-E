import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/controller/profile_provider.dart';
import 'package:troll_e/models/Item_model.dart';

import '../helpers/shopping_api.dart';
import '../models/temp_receipt_model.dart';
import '../models/user_model.dart';

class ItemProvider extends ChangeNotifier {
  List<ItemModel>? itemList = [];
  TempReceiptModel? tempReceipt;

  bool isLoading = false;

  //2NS ATTEMPT
  Future<void> getReceipt({UserModel? user}) async {
    isLoading = true;
    tempReceipt = await getTempReceipt(user: user);
    isLoading = false;
    itemList = tempReceipt?.receipt.items;
    notifyListeners();
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

  Future<void> addItemToTemp(
      {required UserModel? user,
      required String barcode,
      required BuildContext context}) async {
    isLoading = true;
    // for (final item in itemlist!) {
    //   if (item.barcode == barcode) {
    //     //secondScan();
    //     break;
    //   }
    //   else{
    await addItem(user: user, productBarcode: barcode, productQuantity: 1);
    //  }
    // }
    print("item provider after calling add item");
    await getReceipt(
        user: (Provider.of<ProfileProvider>(context, listen: false).user));
    notifyListeners();
    isLoading = false;
  }

  void totalweight() {
    //calculate the total weight of all the items
  }

  void total() {
    // calculate the total amount of all the items
  }
}
