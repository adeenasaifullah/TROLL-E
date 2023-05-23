import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/utility.dart';
import 'package:troll_e/views/shopping_history/shopping_history.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:troll_e/views/homescreen/homescreen.dart';
import '../../controller/profile_provider.dart';
import '../../models/receipt_object_model.dart';
import '../shopping_history/shopping_history.dart';

class Checkout extends StatefulWidget {

  ReceiptObject? reciept;
  Checkout({Key? key, this.reciept}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> with TickerProviderStateMixin {

  @override

  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    final history = Provider.of<ProfileProvider>(context).user?.shoppingHistory;
    int? n = history?.length;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Roboto_heading(textValue: 'Checkout', size: 20.sp),
        backgroundColor: const Color(0xFFBAD3D4),
      ),
      body: Column(
        children: [
          SizedBox(height: 25.h),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              "You have successfully checked out!",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 25.h),
          SizedBox(
            height: 100.h,
            child: Image.asset("Assets/images/checkoutimage.png"),
          ),
          SizedBox(height: 25.h),
    Container(
    width: double.infinity,
    height: 320.h,
        //color: Colors.black12,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Product Description",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Product",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Quantity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Price",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Gross Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              itemCount: history?[n!-1].items.length,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        history![n!-1].items[index].productDescription,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          history![n!-1].items[index].productName,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          history![n!-1].items[index].productQuantity.toString(),
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          history![n!-1].items[index].price.toString(),
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          history![n!-1].items[index].grossTotal.toString(),
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.7,
                    indent: 15,
                    endIndent: 15,
                  ),
                ],
              ),
            ),
          ),
    ] ) ),
          SizedBox(height: 5.h,),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Total: PKR ${history![n!-1].netTotal}',
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          GlowButton(
            child: Text("Done" , style:  TextStyle(color: Colors.white, fontSize: 15.sp),),
            width: 300.w, height: 50.h,
            borderRadius: BorderRadius.circular(15),
            color: Colors.black,
            blurRadius: 0,
            spreadRadius: 0,

            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  HomeScreen()),
              );
              Provider.of<ProfileProvider>(context, listen: false)
                  .result = false;
            },

          ),
        ],
      ),

    );
  }
}
