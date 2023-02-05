import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:troll_e/utility.dart';
import 'package:troll_e/views/forgot_password/forgot_password_details.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          //   Color(0xFFBAD3D4),
          //   Color(0xFFBAD3D4),
          //   // Color(0xFFBAD3D4),
          // ]),
            color: kPrimaryColor
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.h),
            Roboto_heading(textValue: 'Forgot Password', size: 26.sp),
            SizedBox(height: 15.h),
            Roboto_subheading(textValue: 'Please enter your email and we will send \n you a link to return to your account', size: 14.sp),
            SizedBox(height: 60.h),
            //Header(),
            Expanded(child: Container(
              height: displayHeight(context)*0.2,
              width: displayWidth(context),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
              ),
             child: ForgotPasswordDetails(),
            ))
          ],
        ),
      ),
    );
  }
}
