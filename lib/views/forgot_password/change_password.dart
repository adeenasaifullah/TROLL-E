import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utility.dart';

class ChangePasswordScreen extends StatefulWidget {
  late final String? token;

  ChangePasswordScreen({required this.token});
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

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
            Roboto_heading(textValue: 'Change Password', size: 26.sp),
            SizedBox(height: 15.h),
            Roboto_subheading(
                textValue: 'Please enter your new password',
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: displayHeight(context) * 0.02),
                    passfield(
                      validateInput: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password.';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long.';
                        }
                        return null;
                      },
                      // onChanged: (val) {
                      //   setState(() => password = val);
                      // },
                      textController: _newPasswordController,
                      labelText: 'New Password',
                      suffixIcon: Icons.visibility_off,
                      autoFocus: false,

                    ),
                    SizedBox(height: displayHeight(context) * 0.03),
                    passfield(
                      validateInput: (value) {
                          if (value == null || value.isEmpty) {
                          return 'Please confirm your new password.';
                          } else if (value != _newPasswordController.text) {
                          return 'Passwords do not match.';
                          }
                          return null;
                          },
                      textController: _confirmNewPasswordController,
                      labelText: 'Confirm Password',
                      suffixIcon: Icons.visibility_off,
                      //suffixIcon:  obscureIcon ? Icons.visibility : Icons.visibility_off,
                      autoFocus: false,

                    ),
                    SizedBox(height: displayHeight(context) * 0.045),
                    NavButton(
                      buttonText: 'Change Password',
                      textSize: 20.sp,
                      buttonHeight: displayHeight(context)*0.075,
                      buttonWidth: displayWidth(context) * 0.8,
                      onPressed: () async {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          // Perform change password operation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'Password changed successfully.')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
                ),
            ))
          ],
        ),
      ),
    );
  }
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child:
  //     ),
  //   );
  }
