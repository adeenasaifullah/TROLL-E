import 'package:flutter/material.dart';
import '/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_input_wrapper.dart';

class Login extends StatelessWidget {
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
            Roboto_heading(textValue: 'Login', size: 28.sp),
            SizedBox(height: displayHeight(context) * 0.01),
            Roboto_subheading(textValue: 'Sign in to continue', size: 16.sp),
            SizedBox(height: displayHeight(context) * 0.1,),
            //Header(),
            Expanded(child: Container(
              height: displayHeight(context)*0.2,
              width: displayWidth(context),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )
              ),
              child: LoginInputWrapper(),
            ))
          ],
        ),
      ),
    );
  }
}
