import 'package:flutter/material.dart';
import '/utility.dart';

import 'LoginInputWrapper.dart';

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
            color: Color(0xFFBAD3D4)
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: displayHeight(context) * 0.07),
            Roboto_heading(textValue: 'Login', size: 28),
            SizedBox(height: displayHeight(context) * 0.01),
            Roboto_subheading(textValue: 'Sign in to continue', size: 16),
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
              child: LoginInputWrapper(),
            ))
          ],
        ),
      ),
    );
  }
}
