import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/helpers/user_apis.dart';
import 'package:troll_e/views/cart/alert_temp_less_total_weight.dart';
import 'package:troll_e/views/cart/checkout.dart';
import 'package:troll_e/helpers/shopping_api.dart';
import '../../controller/item_provider.dart';
import '../../controller/profile_provider.dart';
import '../../models/Item_model.dart';
import '../../models/shopping_history.dart';
import '../../models/user_model.dart';
import '../../utility.dart';
import 'package:troll_e/views/cart/checkout.dart';

import 'cart_alert_dialog.dart';

class CartInputWrapper extends StatefulWidget {
  const CartInputWrapper({
    Key? key,
  }) : super(key: key);

  @override
  CartInputWrapperState createState() => CartInputWrapperState();
}

class CartInputWrapperState extends State<CartInputWrapper> {
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

  int theftTimer= 0;
  Timer? timer;

  checkShoppingHistory() {
    Provider.of<ProfileProvider>(context, listen: false)
        .getUserProfile(context: context);


    int newlength = Provider.of<ProfileProvider>(context, listen: false)
            .user
            ?.shoppingHistory
            ?.length ??
        0;


    if (newlength > historylength) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _checkout),
      );

      Provider.of<ProfileProvider>(context, listen: false).result = false;



    }
  }

  compareWeight() async {
    List<num>? weights = await Provider.of<ItemProvider>(context, listen: false).getWeights(Provider.of<ProfileProvider>(context, listen: false).user!);
    if(weights!=null){
       tempweight= weights[0];
       totalweight=weights[1];

       if(tempweight>totalweight && ispressed==false){

         showDialog(
           context: context,
           builder: (BuildContext context) {
             return CartAlertDialog();
           },
         );

         } //if condition ending

    } //weight!=null
  }


  compareWeightForScan() async {
    print("INSIDE COMPARE WEIGHT FOR SCAN FUNCTION LINE 98");
    Timer.periodic(Duration(seconds:1), (timer) async {
      // setState(){
        secondsPassed += 1;

      List<num>? weights = await Provider.of<ItemProvider>(context, listen: false).getWeights(Provider.of<ProfileProvider>(context, listen: false).user!);
      if(weights!=null) {
        tempweight = weights[0];
        totalweight = weights[1];

        print("This is tempweight: $tempweight");
        print("This is totalweight: $totalweight");
        print("This is seconds passed: $secondsPassed");
        if (secondsPassed == 12 && tempweight < totalweight) {
          timer.cancel();
          secondsPassed = 0;
                print("YOU HAVE REMOVED AN ITEM FROM YOUR TROLLEY OR INCREASED QUANTITY FOR AN ITEM WITHOUT PLACING IN TROLLEY");
        //alert box shown, as soon as alert box closes, call this method again.
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CartAlertDialogTwo(
                  onCloseDialog: () {
                    // This function will be called when the dialog is closed

                    compareWeightForScan(); // Call the function again
                  }
              );
            },
          );

        }

         if (secondsPassed == 12 && tempweight > totalweight) {
          timer.cancel();
            secondsPassed = 0;
          print("YOU HAVE PLACED AN ITEM IN YOUR TROLLEY OR DECREASED QUANTITY FOR AN ITEM WITHOUT REMOVING FROM TROLLEY");

          //alert box shown, as soon as alert box closes, call this method again.

        }

        // else if (secondsPassed == 30){
        //   timer.cancel();
        //   secondsPassed = 0;
        // }

         if(secondsPassed <= 12){

          List<num>? weights = await Provider.of<ItemProvider>(context, listen: false).getWeights(Provider.of<ProfileProvider>(context, listen: false).user!);
          if(weights!=null){

          }
          else {
            print("Timer cancelled");
            timer.cancel();
          }
        }
      }

      else {

        timer.cancel();
        secondsPassed = 0;
      }

  });
  }

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

  void dispose() {
    streamController.close();
  }

  @override
  void initState() {
    //Provider.of<ProfileProvider>(context).user?.shoppingHistory
    Provider.of<ProfileProvider>(context, listen: false)
        .getUserProfile(context: context);

    historylength = Provider.of<ProfileProvider>(context, listen: false)
            .user
            ?.shoppingHistory
            ?.length ??
        0;


    callGetReceipt();
    // TODO: implement initState

    //checking if user has checked out or not after every 5 seconds
    Timer.periodic(Duration(seconds: 5), (timer) {

      checkShoppingHistory();

    });

    //checking weight of trolley continuously
    Timer.periodic(Duration(seconds: 1), (timer) async {
      compareWeight();
    });


    super.initState();
  }

  void callGetReceipt() async {
    await Provider.of<ItemProvider>(context, listen: false).getReceipt(
        user: Provider.of<ProfileProvider>(context, listen: false).user);

    // final profileProvider = Provider.of<ProfileProvider>(context);
    //  final itemProvider = Provider.of<ItemProvider>(context);_SignupInputWrapperState
    //  items =  itemProvider.getReceipt(user: profileProvider.user) as List<ItemModel>?;
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      body: itemProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : itemProvider.itemList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150.h,
                    ),
                    Center(
                      child: Text(
                        "Your Cart is Empty\nScan to add items to the cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: kPrimaryDarkColor,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250.h,
                    ), // add some spacing between the widgets
                    // Expanded( // add Expanded to take the remaining space
                    //   child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "Net Weight",
                              style: GoogleFonts.robotoCondensed(
                                color: const Color(0xFF779394),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Container(
                              width: 60.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFF779394),
                                  width: 1.w,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "0",
                                style: GoogleFonts.robotoCondensed(
                                  color: const Color(0xFF779394),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 35.w),
                        SizedBox(
                          height: 50.h,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(90.0, 50.0),
                              backgroundColor: const Color(0xff262626),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              ispressed=true;
                              await _scanBR();


                              bool firstScan = await itemProvider.addItemToTemp(
                                  user: Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .user,
                                  barcode: _result,
                                  context: context);


                              ispressed=false;
                              compareWeightForScan();
                            },
                            icon: (Image.asset('Assets/icons/scanner.png')),
                            label: const Text(''),
                          ),
                        ),
                        SizedBox(width: 35.w),
                        Column(
                          children: <Widget>[
                            Text(
                              "Total Cost",
                              style: GoogleFonts.robotoCondensed(
                                color: const Color(0xFF779394),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Container(
                              width: 70.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFF779394),
                                  width: 1.w,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "PKR 0.00",
                                style: GoogleFonts.robotoCondensed(
                                  color: const Color(0xFF779394),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              : Center(
                  child: Form(
                  key: _checkinput,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: itemProvider.itemList?.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.7.w,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 8, right: 8, bottom: 8),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 73.h,
                                            width: 73.w,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fitHeight,
                                                  image: NetworkImage(
                                                      (itemProvider
                                                              .itemList![index]
                                                              ?.image)
                                                          .toString())),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                (itemProvider.itemList![index]
                                                        ?.productName)
                                                    .toString(),
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            SizedBox(height: 4.h),
                                            Text(
                                              (itemProvider.itemList![index]
                                                      ?.productDescription)
                                                  .toString(),
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                color: const Color(0xFF779394),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 15.h),
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "PKR ${(itemProvider.itemList![index]?.price).toString()}",
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    color: Colors.black54,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "Quantity: ${(itemProvider.itemList![index]?.productQuantity).toString()}",
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    color: const Color(
                                                        0xFF779394),
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //trailing: Text("Qty: ${itemProvider.itemList![index]?.productQuantity}"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Net Weight",
                                style: GoogleFonts.robotoCondensed(
                                    color: const Color(0xFF779394),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 3.h),
                              Container(
                                width: 60.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color(0xFF779394),
                                    width: 1.w,
                                  ),
                                ),
                                alignment: Alignment.center,
                                // child: const Center(
                                child: Text(
                                  itemProvider.tempReceipt?.receipt.totalWeight
                                          .toString() ??
                                      '0',
                                  style: GoogleFonts.robotoCondensed(
                                    color: const Color(0xFF779394),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 35.w),
                          SizedBox(
                            height: 50.h,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(90.0, 50.0),
                                backgroundColor: const Color(0xff262626),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () async {
                                ispressed = true;
                                bool scanResult =await _scanBR();
                                late bool firstScan;
                                if (scanResult ==true) {
                                  firstScan =
                                  await itemProvider.addItemToTemp(
                                      user: Provider
                                          .of<ProfileProvider>(
                                          context,
                                          listen: false)
                                          .user,
                                      barcode: _result,
                                      context: context);
                                  print("THIS IS THE VALUE OF FIRST SCAN");
                                  print(firstScan);

                                  List<num>? weights = await Provider.of<ItemProvider>(context, listen: false).getWeights(Provider.of<ProfileProvider>(context, listen: false).user!);

                                  if (firstScan == false && (weights == null)) {
                                    //context.mounted is being used cuz it said Don't use 'BuildContext's across async gaps
                                    //and onPressed is async so i think i need to do this
                                    if (!context.mounted) return;

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'What would you like to do?',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          content: const Text(
                                            "Do you want to increase or decrease the item quantity?",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
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
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // close the previous dialog box
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                        context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                              "Enter Quantity to Increase",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextFormField(
                                                                controller:
                                                                increase_qty,
                                                                decoration:
                                                                InputDecoration(
                                                                  fillColor:
                                                                  const Color(
                                                                      0xFFF4F1F1),
                                                                  filled: true,
                                                                  border:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10.0),
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                        6.w,
                                                                        color: Color(
                                                                            0xFFF4F1F1)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              ElevatedButton(
                                                                style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                  const Color(
                                                                      0xFF000000),
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10.0),
                                                                  ),
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      vertical: 10
                                                                          .h,
                                                                      horizontal:
                                                                      25.w),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  if (_checkinput
                                                                      .currentState!
                                                                      .validate()) {
                                                                    await itemProvider
                                                                        .increaseItemQuantity(
                                                                        user: Provider
                                                                            .of<
                                                                            ProfileProvider>(
                                                                            context,
                                                                            listen:
                                                                            false)
                                                                            .user,
                                                                        barcode:
                                                                        _result,
                                                                        product_qty:
                                                                        int
                                                                            .parse(
                                                                            increase_qty
                                                                                .text),
                                                                        context:
                                                                        context);
                                                                    if (!context
                                                                        .mounted)
                                                                      return;
                                                                    Navigator
                                                                        .of(
                                                                        context)
                                                                        .pop();
                                                                    showDialog(
                                                                      context:
                                                                      context,
                                                                      builder:
                                                                          (
                                                                          BuildContext
                                                                          context) {
                                                                        Future
                                                                            .delayed(
                                                                            const Duration(
                                                                                seconds: 1),
                                                                                () {
                                                                              Navigator
                                                                                  .of(
                                                                                  context)
                                                                                  .pop();
                                                                            });
                                                                        return const AlertDialog(
                                                                          title: Text(
                                                                              "Quantity Increased!"),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                  if(secondsPassed==0) {
                                                                    compareWeightForScan();
                                                                  }
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
                                                    },
                                                    child: const Text(
                                                        'Increase'),
                                                  ),
                                                  SizedBox(width: 16.w),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.white,
                                                      backgroundColor:
                                                      const Color(0xFF000000),
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
                                                      //need to check if item qty is one or not (bool qty_one returns true if qty was one else false
                                                      //if one then directly remove and show prompt that Item Removed!
                                                      //else ask for quantity to decrease

                                                      bool qtyOne =
                                                      await itemProvider.remove(
                                                          context: context,
                                                          user: Provider
                                                              .of<
                                                              ProfileProvider>(
                                                              context,
                                                              listen: false)
                                                              .user,
                                                          barcode: _result);
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
                                                                      BorderRadius
                                                                          .circular(
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
                                                                      BorderRadius
                                                                          .circular(
                                                                          10.0),
                                                                    ),
                                                                    padding: EdgeInsets
                                                                        .symmetric(
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
                                                                      await itemProvider
                                                                          .decreaseItemQuantity(
                                                                          user: Provider
                                                                              .of<
                                                                              ProfileProvider>(
                                                                              context,
                                                                              listen: false)
                                                                              .user,
                                                                          context:
                                                                          context,
                                                                          barcode:
                                                                          _result,
                                                                          product_qty:
                                                                          int
                                                                              .parse(
                                                                              decrease_qty
                                                                                  .text));
                                                                      if (!context
                                                                          .mounted)
                                                                        return;
                                                                      Navigator
                                                                          .of(
                                                                          context)
                                                                          .pop();
                                                                      showDialog(
                                                                        context:
                                                                        context,
                                                                        builder:
                                                                            (
                                                                            BuildContext
                                                                            context) {
                                                                          Future
                                                                              .delayed(
                                                                              Duration(
                                                                                  seconds: 1),
                                                                                  () {
                                                                                Navigator
                                                                                    .of(
                                                                                    context)
                                                                                    .pop();
                                                                              });
                                                                          return const AlertDialog(
                                                                            title:
                                                                            Text(
                                                                                "Quantity Decreased!"),
                                                                          );
                                                                        },
                                                                      );
                                                                    }
                                                                    if(secondsPassed==0) {
                                                                      compareWeightForScan();
                                                                    }
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
                                                    },
                                                    child: const Text(
                                                        'Decrease'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  compareWeightForScan();
                                  if(firstScan==false && weights!=null){
                                    showSnackBar(context, "Please first place the item in trolley, or decrease quantity");
                                  }
                                }
                            // compareWeightForScan();
                                ispressed = false;


                              },
                              icon: (Image.asset('Assets/icons/scanner.png')),
                              label: const Text(''),
                            ),
                          ),
                          SizedBox(width: 35.w),
                          Column(
                            children: <Widget>[
                              Text(
                                "Total Cost",
                                style: GoogleFonts.robotoCondensed(
                                  color: const Color(0xFF779394),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Container(
                                width: 70.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color(0xFF779394),
                                    width: 1.w,
                                  ),
                                ),
                                alignment: Alignment.center,
                                // child: const Center(
                                child: Text(
                                  itemProvider.tempReceipt?.receipt.netTotal
                                          .toString() ??
                                      '0',
                                  style: GoogleFonts.robotoCondensed(
                                    color: const Color(0xFF779394),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // FloatingActionButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => Checkout()),
                      //     );
                      //   },
                      // )
                    ],
                  ),
                )),

  // })
    );
  }
}

