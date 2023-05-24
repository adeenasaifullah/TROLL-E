import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/views/cart/cart_input_wrapper.dart';

import '../../controller/item_provider.dart';
import '../../controller/profile_provider.dart';
import '../../helpers/user_apis.dart';
import '../../models/Item_model.dart';
import '../../models/shopping_history.dart';
import './cart_input_wrapper.dart' as Cart;
import 'checkout.dart';


class CartAlertDialogTwo extends StatefulWidget {
   final VoidCallback onCloseDialog;

  const CartAlertDialogTwo({
    Key? key, required this.onCloseDialog,
  }) : super(key: key);

  @override
  _CartAlertDialogTwoState createState() => _CartAlertDialogTwoState();
}

class _CartAlertDialogTwoState extends State<CartAlertDialogTwo> {
  bool shouldCloseDialog = false;
  String _result = "";
  final TextEditingController weightController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController increase_qty = TextEditingController();
  final TextEditingController decrease_qty = TextEditingController();
  bool ispressed=false;
  final _checkinput = GlobalKey<FormState>();
  StreamController<ShoppingHistoryModel> streamController = StreamController();
  late final int historylength;
  Checkout _checkout = Checkout();
  num tempweight=0;
  num totalweight=0;
  num oldcartlength = 0;
  num newcartlength = 0;

  List<ItemModel>? items = [];
  int secondsPassed = 0;
  Timer? timer;


  CartInputWrapperState cartObject = new CartInputWrapperState();


  Future<bool> _scanBR() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
          "#000000", "Cancel", true, ScanMode.BARCODE)
          .then((value) => setState(() => _result = value));
      return true;
      // setState(() {
      //   _result = value;
      // });
    } catch (ex) {
      setState(() {
        _result = "Unknown Error $ex";
      });
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // Simulate the condition being satisfied after 2 seconds

    Timer.periodic(Duration(seconds: 1), (timer) async {
      List<num>? weights = await Provider.of<ItemProvider>(context, listen: false).getWeights(Provider.of<ProfileProvider>(context, listen: false).user!);
      if(weights!=null) {
      }
      else {

        setState(() {
          shouldCloseDialog = true;
        });

      }

    });



  }


  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    if (shouldCloseDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // cartobj.compareWeightForScan();
        Navigator.of(context).pop(); // Close the dialog

      });
    }

    return WillPopScope(
        onWillPop: () async {
          // Disable the back button
          return false;

        },
        child: AlertDialog(
          title: Text("It seems an item is missing from your trolley. You either:"
              "\n1. Scanned an item without placing it \n    in your trolley OR"
              "\n2. Removed an item from your trolley \n    without scanning it",

            style: TextStyle(
              fontWeight:
              FontWeight
                  .w500,
              fontSize: 13.sp
            ),),
          actions: [
            ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF000000),
                  primary: Colors.white,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                        10.0),
                  ),
                  padding:
                  EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 15.w),
                  textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight:
                      FontWeight.w400),
                ),
              onPressed: () async {

                ispressed = true;
                bool scanValue = await _scanBR();

                if(scanValue == false){
                  showSnackBar(context, "Please scan the item again");
                }
                else {
                  int itemIndex = -1;
                  for (var index = 0; index < itemProvider.itemList.length; index++) {
                    if (itemProvider.itemList[index]?.barcode == _result) {
                      itemIndex = index;
                      break;
                    }
                  }

                  if (itemProvider.itemList![itemIndex]?.barcode == _result)
                  {
                    bool qtyOne = await itemProvider.remove(
                        context: context, user: Provider.of<ProfileProvider>(context, listen: false).user, barcode: _result);
                    if (qtyOne == true) {
                      if (!context.mounted) return;
                      showDialog(context: context, builder: (BuildContext context) {
                        Future.delayed(
                            Duration(
                                seconds: 1),
                                () {
                              Navigator.of(
                                  context)
                                  .pop();
                            });
                        return const AlertDialog(
                          title: Text(
                              "Item Removed!"),
                        );
                      },
                      );
                    } else {
                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        builder: (BuildContext
                        context) {
                          return AlertDialog(
                            title: const Text(
                              "Enter Quantity to Decrease",
                              style: TextStyle(
                                fontWeight:
                                FontWeight
                                    .w500,
                              ),
                            ),
                            actions: <Widget>[
                              TextFormField(
                                controller:
                                decrease_qty,
                                decoration:
                                InputDecoration(
                                  fillColor:
                                  const Color(
                                      0xFFF4F1F1),
                                  filled: true,
                                  border:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0),
                                    borderSide: const BorderSide(
                                        width:
                                        6,
                                        color: Color(
                                            0xFFF4F1F1)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              ElevatedButton(
                                style: ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                  const Color(
                                      0xFF000000),
                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                      10.h,
                                      horizontal:
                                      25.w),
                                ),
                                onPressed:
                                    () async {

                                  // if (_checkinput
                                  //     .currentState!
                                  //     .validate())
                                      if(decrease_qty.value!=null || decrease_qty.text!="0" )
                                  {
                                    print("CHECKINPUT IS VALIDATED");
                                    print(_checkinput);

                                    await itemProvider.decreaseItemQuantity(
                                        user: Provider.of<ProfileProvider>(context, listen: false)
                                            .user,
                                        context:
                                        context,
                                        barcode:
                                        _result,
                                        product_qty:
                                        int.parse(decrease_qty.text));
                                    // if (!context.mounted) return;
                                    Navigator.of(
                                        context)
                                        .pop();
                                    showDialog(
                                      context:
                                      context,
                                      builder:
                                          (BuildContext
                                      context) {
                                        Future.delayed(
                                            Duration(seconds: 1),
                                                () {
                                              print("TRYING TO POP ");
                                              Navigator.of(context)
                                                  .pop();
                                            });
                                        return const AlertDialog(
                                          title:
                                          Text("Quantity Decreased!"),
                                        );
                                      },
                                    );
                                  }
                                  print("IF KE BAHAR AGAYEEEEEEE");
                                  cartObject.compareWeightForScan();
                                },
                                child: Text(
                                  "Save",
                                  style:
                                  TextStyle(
                                    color: Colors
                                        .white,
                                    fontSize:
                                    15.sp,
                                    fontWeight:
                                    FontWeight
                                        .w400,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                  ispressed=false;

                }

              },
              child: Text("Decrease"))],

        )
    );
  }

}
