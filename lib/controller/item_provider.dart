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
    print("before getreceipt");
    tempReceipt = await getTempReceipt(user: user);
    print("after getreceipt");
    itemList =  tempReceipt?.receipt.items;
    print("THIS IS THE GET RECEIPT IN PROVIDER SO PRODUCTNAME HERE IS");
    print(itemList?[0].productName);
    isLoading = false;
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

  Future<bool> addItemToTemp(
      {required UserModel? user,
      required String barcode,
      required BuildContext context}) async {
    bool firstscan=true;
    isLoading = true;
     for (final item in itemList!) {
      if (item.barcode == barcode) {
    //this means item has been scanned before so return back to the screen with false value
         firstscan=false;
        break;
      }
      else{
     await addItem(user: user, productBarcode: barcode, productQuantity: 1);
     }
     }
    print("item provider after calling add item");
    await getReceipt(user: (Provider.of<ProfileProvider>(context, listen: false).user));
    notifyListeners();
    isLoading = false;
    return firstscan;
  }

  // void secondScan({required BuildContext context}){
  //
  // }

  Future<void> increaseItemQuantity({required UserModel? user, required String? barcode, required int product_qty, }) async {
    isLoading=true;
    await increaseQuantity(user: user, productBarcode: barcode, productQuantity: product_qty);
    isLoading=false;
    notifyListeners();
  }

  Future<void> decreaseItemQuantity({required UserModel? user, required String? barcode, required int product_qty, }) async {
    isLoading=true;
    await decreaseQuantity(user: user, productBarcode: barcode, productQuantity: product_qty);
    isLoading=false;
    notifyListeners();
  }

  Future<bool> remove({
    required UserModel? user,
    required String? barcode,}) async {
    bool qty_one = false;

      for (final item in itemList!) {
      if (item.barcode == barcode || item.productQuantity ==1) {
        //call api to decreaseqty and send qty as 1
        //we will not be showing any dialog now to ask for qty
        isLoading=true;
        await decreaseQuantity(user: user, productBarcode: barcode, productQuantity: 1);
        isLoading=false;
        qty_one=true;
         }
      }


    return qty_one;
  }

  void totalweight() {
    //calculate the total weight of all the items
  }

  void total() {
    // calculate the total amount of all the items
  }
}
