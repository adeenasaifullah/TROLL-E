import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utility.dart';

class TokenVerificationScreen extends StatefulWidget {
  final String resetPasswordToken;

  TokenVerificationScreen({required this.resetPasswordToken});

  @override
  _TokenVerificationScreenState createState() =>
      _TokenVerificationScreenState();
}

class _TokenVerificationScreenState extends State<TokenVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  //late String _enteredToken;
  late final TextEditingController enteredToken = TextEditingController();

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
              SizedBox(height: 50.h),
              Roboto_heading(textValue: 'Verify Token', size: 26.sp),
              SizedBox(height: 15.h),
              Roboto_subheading(
                textValue: 'Please enter the token send to your email.',
                size: 14.sp),
                SizedBox(height: 60.h),
              //Header(),
              Expanded(child: Container(
                height: displayHeight(context) * 0.2,
                width: displayWidth(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                  )
              ),
                child: Padding(
                  padding: EdgeInsets.all(50),
                 child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: displayHeight(context) * 0.02),
                      field(
                        validateInput: (value) {
                            if (value == null || value.isEmpty) {
                            return 'Please enter the token';
                            }
                            if (value != widget.resetPasswordToken) {
                            return 'Incorrect token. Please try again';
                            }
                            return null;
                            },
                            // onSaved: (value) {
                            // enteredToken = value!;
                            // },

                        // onChanged: (val) {
                        //   setState(() => email = val);
                        // },
                        textController: enteredToken,
                        labelText: 'Token',
                        //hintText: 'email',
                        // prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF838383)),
                        autoFocus: false,
                      ),
                      SizedBox(height: displayHeight(context) * 0.045),
                      NavButton(
                        buttonText: 'SUBMIT',
                        textSize: 20.sp,
                        buttonHeight: displayHeight(context)*0.075,
                        buttonWidth: displayWidth(context) * 0.8,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Navigate to next screen or perform further actions
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
              ),
            ],
              ),
              )
    );
  }
}