import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utility.dart';

class OTPForm extends StatefulWidget {
  const OTPForm({Key? key}) : super(key: key);

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 150.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 55.w,
                        child: TextFormField(
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 20.sp),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin2FocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 55.w,
                        child: TextFormField(
                          focusNode: pin2FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 20.sp),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) => nextField(value, pin3FocusNode),
                        ),
                      ),
                      SizedBox(
                        width: 55.w,
                        child: TextFormField(
                          focusNode: pin3FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 20.sp),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) => nextField(value, pin4FocusNode),
                        ),
                      ),
                      SizedBox(
                        width: 55.w,
                        child: TextFormField(
                          focusNode: pin4FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 20.sp),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.length == 1) {
                              pin4FocusNode!.unfocus();
                              // Then you need to check is the code is correct or not
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 140.h),
                  NavButton(
                    buttonText: 'Continue',
                    textSize: 20.sp,
                    buttonHeight: 50.h,
                    buttonWidth: 300.w,
                    onPressed: () => {
                      //do something
                    },
                  ),
                  SizedBox(height: 15.h),
                  GestureDetector(
                    onTap: () {
                      // OTP code resend
                    },
                    child: const Text(
                      "Resend OTP Code",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
