import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/controller/profile_provider.dart';
import 'package:troll_e/models/Item_model.dart';

import '../helpers/shopping_api.dart';
import '../models/temp_receipt_model.dart';
import '../models/user_model.dart';

class ItemProvider extends ChangeNotifier {
  List<ItemModel> itemList = [];
  late TempReceiptModel tempReceipt;
  bool checkTemp = false;

  bool isLoading = false;
  void checkTempReceipt(UserModel? user) async {
    if(await getTempReceipt(user: user) != null) {
      checkTemp = true;
      notifyListeners();
    } else {
      checkTemp = false;
      notifyListeners();
    }
    return false;
  }


  //2NS ATTEMPT
  Future<void> getReceipt({UserModel? user}) async {
    isLoading = true;
    print("before getreceipt");
    tempReceipt = (await getTempReceipt(user: user))!;
    print("after getreceipt");
    itemList = tempReceipt.receipt.items;
    print("THIS IS THE GET RECEIPT IN PROVIDER SO PRODUCTNAME HERE IS");
    //print(itemList?[0].productName);
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
    bool firstscan = true;
    isLoading = true;
    print(user?.userId);
    print(barcode);
    print("inside additemtotemp provider");

    if (itemList.isEmpty) {
      await addItem(user: user, productBarcode: barcode, productQuantity: 1);
    } else {
      for (final item in itemList) {
        if (item.barcode == barcode) {
          //this means item has been scanned before so return back to the screen with false value
          firstscan = false;
          print('');
          break;
        }
      }
      if (firstscan == true) {
        await addItem(user: user, productBarcode: barcode, productQuantity: 1);
        print("inside item provider after calling add item");
      }
    }
    // print("item provider after calling add item");
    await getReceipt(
        user: (Provider.of<ProfileProvider>(context, listen: false).user));
    notifyListeners();
    isLoading = false;
    return firstscan;
  }

  // void secondScan({required BuildContext context}){
  //
  // }

  Future<void> increaseItemQuantity({
    required UserModel? user,
    required String? barcode,
    required BuildContext context,
    required int product_qty,
  }) async {
    isLoading = true;
    await increaseQuantity(
        user: user, productBarcode: barcode, productQuantity: product_qty);
    await getReceipt(
        user: (Provider.of<ProfileProvider>(context, listen: false).user));
    isLoading = false;
    notifyListeners();
  }

  Future<List<num>?> getWeights(UserModel user) async {

    List<num>? weights = await compareWeight(user: user);
    if (weights != null) {
      return weights;
    }
    notifyListeners();
  }

  Future<void> decreaseItemQuantity({
    required UserModel? user,
    required String? barcode,
    required BuildContext context,
    required int product_qty,
  }) async {
    isLoading = true;
    await decreaseQuantity(
        user: user, productBarcode: barcode, productQuantity: product_qty);
    await getReceipt(
        user: (Provider.of<ProfileProvider>(context, listen: false).user));
    print("DECREASE QTY ITEM PROVIDER CALLED");

    isLoading = false;
    notifyListeners();
  }

  Future<bool> remove({
    required UserModel? user,
    required BuildContext context,
    required String? barcode,
  }) async {
    bool qty_one = false;

      for (final item in itemList!) {
      if (item.barcode == barcode && item.productQuantity == 1) {
        //call api to decreaseqty and send qty as 1
        //we will not be showing any dialog now to ask for qty
        isLoading=true;
        await decreaseQuantity(user: user, productBarcode: barcode, productQuantity: 1);

        qty_one=true;
        print("item provider removingggggggggggggggggggg");
       // await getReceipt(user: (Provider.of<ProfileProvider>(context, listen: false).user));
       print("after get receipt");
       isLoading=false;
         }
      }
      isLoading=true;
    await getReceipt(user: (Provider.of<ProfileProvider>(context, listen: false).user));
      print("GET RECEIPT CALLED IN ITEM PROVIDER IN REMOVE");
      isLoading=false;
      notifyListeners();
    return qty_one;
  }

  void totalweight() {
    //calculate the total weight of all the items
  }

  void total() {
    // calculate the total amount of all the items
  }
}
