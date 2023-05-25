import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utility.dart';

class DemoScreenOne extends StatefulWidget {
  late  double left = 0;
  late  double top = 0;
  @override
  _DemoScreenOneState createState() => _DemoScreenOneState();
}

class _DemoScreenOneState extends State<DemoScreenOne> {
  bool cartConnected = false;


  @override
  Widget build(BuildContext context) {
    widget.left = MediaQuery.of(context).size.width / 2 - 105.w;
    widget.top = MediaQuery.of(context).size.height / 2 - 105.h;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80.h,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimaryDarkColor,
                    radius: 105.r,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100.r,
                      child: GlowButton(
                        width: 170.w,
                        height: 170.h,
                        child: Image.asset(
                          'Assets/icons/cart.png',
                          width: 50.w,
                        ),
                        onPressed: () {},
                        borderRadius: BorderRadius.circular(500.r),
                        color: cartConnected ? kPrimaryDarkColor : Color(0xffDDE7E8),
                        blurRadius: cartConnected ? 50 : 0,
                        spreadRadius: cartConnected ? 10 : 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlowButton(
                    child: Text(
                      "Start Shopping",
                      style: TextStyle(color: Colors.white),
                    ),
                    width: 300.w,
                    height: 50.h,
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black54,
                    blurRadius: 0,
                    spreadRadius: 0,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Roboto_subheading(textValue: "Connect Cart" , size: 18.sp),
                ],
              ),
            ),
            SizedBox(
              height: 20.h
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Padding(
                    padding: const EdgeInsets.only(left:15.0, right:15.0),
                    child: Roboto_text(textValue: 'Tap the connect button to scan the QR code on the cart.If the button starts glowing, click the start shopping button.', size: 16.sp),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
