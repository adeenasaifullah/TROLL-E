import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controller/item_provider.dart';
import '../../controller/profile_provider.dart';

class CartAlertDialog extends StatefulWidget {
  @override
  CartAlertDialogState createState() => CartAlertDialogState();
}

class CartAlertDialogState extends State<CartAlertDialog> {
  bool shouldCloseDialog = false;

  @override
  void initState() {

    super.initState();
    // Simulate the condition being satisfied after 2 seconds
    print("init state of alert dialog");
    Timer.periodic(Duration(seconds: 1), (timer) async {
      List<num>? weights = await Provider.of<ItemProvider>(context, listen: false).getWeights(Provider.of<ProfileProvider>(context, listen: false).user!);
      print("INSIDE ALERT DIALOG");
      if(weights!=null) {

        print("THIS is not nullllllllllllllllll");
      }
      else {
        print("THIS SHOULD CLOSE THE POP UP");
        setState(() {
          shouldCloseDialog = true;
        });

      }

    });
  }


  @override
  Widget build(BuildContext context) {
    if (shouldCloseDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop(); // Close the dialog
      });
    }

    return WillPopScope(
        onWillPop: () async {
      // Disable the back button
      return false;

    },
    child:const AlertDialog(
      title: Text("You have placed an item in the cart without scanning \n "
          "Please remove the item and scan it first",
        style: TextStyle(fontWeight: FontWeight.w500,),),

    )
    );
  }
}