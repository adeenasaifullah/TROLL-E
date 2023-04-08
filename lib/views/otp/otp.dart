import 'package:flutter/material.dart';
import 'package:troll_e/views/otp/otp_form.dart';
import '/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kPrimaryColor,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.h),
            Roboto_heading(textValue: 'OTP Verification', size: 26.sp),
            SizedBox(height: 15.h),
            Roboto_subheading(
                textValue: 'We sent your code to +92 398 860 ***', size: 14.sp),
            buildTimer(),
            SizedBox(height: 60.h),
            //Header(),
            Expanded(
              child: Container(
                width: displayWidth(context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: const OTPForm(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Roboto_subheading(
            textValue: 'This code will be expired in ', size: 16),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
