import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/views/cart/cart_input_wrapper.dart';

import '../../controller/item_provider.dart';
import '../../controller/profile_provider.dart';
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


  _scanBR() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
          "#000000", "Cancel", true, ScanMode.BARCODE)
          .then((value) => setState(() => _result = value));
      // setState(() {
      //   _result = value;
      // });
    } catch (ex) {
      setState(() {
        _result = "Unknown Error $ex";
      });
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
              "\n 1. Scanned an item without placing it in your trolley OR"
              "\n 2. Removed an item from your trolley without scanning it",

            style: TextStyle(fontWeight: FontWeight.w500,),),
          actions: [
            ElevatedButton(
              onPressed: () async {

                Navigator.of(context).pop();

                ispressed = true;
                await _scanBR();

                bool firstScan =
                    await itemProvider.addItemToTemp(
                    user: Provider.of<ProfileProvider>(
                        context,
                        listen: false)
                        .user,
                    barcode: _result,
                    context: context);

                if (firstScan == false) {
                  //context.mounted is being used cuz it said Don't use 'BuildContext's across async gaps
                  //and onPressed is async so i think i need to do this

                  if (!context.mounted) return;

                  //need to check if item qty is one or not (bool qty_one returns true if qty was one else false
                  //if one then directly remove and show prompt that Item Removed!
                  //else ask for quantity to decrease

                  bool qtyOne =
                  await itemProvider.remove(
                      context: context, user: Provider.of<ProfileProvider>(context, listen: false).user, barcode: _result);
                  if (qtyOne == true) {
                    if (!context.mounted)
                      return;
                    Navigator.of(context)
                        .pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext
                      context) {
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
                    if (!context.mounted)
                      return;
                    Navigator.of(context)
                        .pop(); // closes the previous dialog box
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
                                if (_checkinput
                                    .currentState!
                                    .validate()) {
                                  await itemProvider.decreaseItemQuantity(
                                      user: Provider.of<ProfileProvider>(context, listen: false)
                                          .user,
                                      context:
                                      context,
                                      barcode:
                                      _result,
                                      product_qty:
                                      int.parse(decrease_qty.text));
                                  if (!context
                                      .mounted)
                                    return;
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
                                widget.onCloseDialog();
                                setState(() {

                                  shouldCloseDialog = true;
                                });
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

              },
              child: Text("Decrease"))],

        )
    );
  }

}
