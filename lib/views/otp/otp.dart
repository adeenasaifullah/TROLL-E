import 'package:flutter/material.dart';
import 'package:troll_e/views/otp/otp_form.dart';
import '/utility.dart';

class OTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(

            color: kPrimaryColor
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: displayHeight(context) * 0.07),
            Roboto_heading(textValue: 'OTP Verification', size: 28),
            SizedBox(height: displayHeight(context) * 0.01),
            Roboto_subheading(textValue: 'We sent your code to +92 398 860 ***', size: 16),
            buildTimer(),
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
              child: OTPForm(),
            ))
          ],
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Roboto_subheading(textValue: 'This code will be expired in ', size: 16),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
