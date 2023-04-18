import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/views/shopping_history/shopping_history.dart';
import 'package:flutter_gif/flutter_gif.dart';

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
  late FlutterGifController controller1;
  @override
  void initState() {
    controller1 = FlutterGifController(vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller1.repeat(
        min: 0,
        max: 60,
        period: const Duration(seconds: 3),
      );
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    final history = Provider.of<ProfileProvider>(context).user?.shoppingHistory;
    int? n = history?.length;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(((history?[n!-1].date)).toString(), style: TextStyle(color: Colors.black,),),

        backgroundColor: const Color(0xFFBAD3D4),
      ),
      body: Column(
        children: [
          SizedBox(height: 25.h),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text("You have successfully checked out!", style: TextStyle(fontSize: 15.sp , fontWeight: FontWeight.w500),),
          ),
          SizedBox(height: 25.h),
          // GifImage(
          //   controller: controller1,
          //   image: const AssetImage("Assets/images/checkoutgif.gif"),
          // ),
          //Image.asset("Assets/images/checkoutgif.gif", gaplessPlayback: false),
          SizedBox(height: 150.h, child: Image.asset("Assets/images/checkout.png"),),
          SizedBox(height: 25.h),
          Padding(padding: EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Product Description",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
      ),
          SizedBox(height: 25.h),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: const [
                Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Discount", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0) ,
              itemCount: history?[n!-1].items.length,
              itemBuilder: (context, index) => Column(
                children: [

                  ListTile(

                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(history![n!-1].items[index].productName, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Row(
                      children: [
                        Text(history![n!-1].items[index].productQuantity.toString()),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(history![n!-1].items[index].price.toString()),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text('0.00'),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(history![n!-1].items[index].grossTotal.toString()),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.7, indent: 15, endIndent: 15),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
