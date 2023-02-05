import 'package:flutter/material.dart';
import '/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'signup_input_wrapper.dart';

class Signup extends StatelessWidget {
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
            SizedBox(height: displayHeight(context) * 0.07),
            Roboto_heading(textValue: 'Sign Up', size: 26.sp),
            SizedBox(height: displayHeight(context) * 0.01),
            Roboto_subheading(textValue: 'Register to create an account', size: 14.sp),
            SizedBox(height: displayHeight(context) * 0.1,),
            //Header(),
            Expanded(child: Container(
              width: displayWidth(context),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
              ),
              child: SignupInputWrapper(),
            ))
          ],
        ),
      ),
    );
  }
}
