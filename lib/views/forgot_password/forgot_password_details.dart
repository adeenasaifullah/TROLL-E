
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/controller/profile_provider.dart';
import 'package:troll_e/utility.dart';
import 'package:troll_e/views/forgot_password/token_verification.dart';
import 'package:webview_flutter/webview_flutter.dart%20';
import '../../helpers/user_apis.dart';
import '../login_signup/Signup.dart';

class ForgotPasswordDetails extends StatefulWidget {
  const ForgotPasswordDetails({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordDetails> createState() => _ForgotPasswordDetailsState();
}

class _ForgotPasswordDetailsState extends State<ForgotPasswordDetails> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final resetemail = Provider.of<ProfileProvider>(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(30),
    child: Form(
    key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 100.h),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),

              child: Column(
                  children: <Widget>[
                    field(
                      validateInput: (email) {
                        if (emailController.text.isEmpty) {
                          return "* Required";
                        }
                        if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email!)
                        ) {
                          return "Enter correct email address";
                        } else {
                          return null;
                        }
                      },
                      // onChanged: (val) {
                      //   setState(() => email = val);
                      // },
                      textController: emailController,
                      labelText: 'Email',
                      //hintText: 'email',
                      // prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF838383)),
                      autoFocus: false,
                    ),


                  ]
              )
          ),

          SizedBox(height: 100.h),
          NavButton(
            buttonText: 'Continue',
            textSize: 20.sp,
            buttonHeight: displayHeight(context)*0.075,
            buttonWidth: displayWidth(context) * 0.8,
            onPressed: () async {
            if (_formKey.currentState != null &&
            _formKey.currentState!.validate()) {
              await forgotpassword(context: context, email: emailController.text);
              String token = resetemail.passwordresettoken;
              if ((token.isNotEmpty)) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TokenVerificationScreen(resetPasswordToken: token,)));
              }
             }
            },
          ),
          SizedBox(height: 20.h,),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Signup()));
            },
            child: Text("Don't have an account? Sign up",
                style: GoogleFonts.robotoCondensed(
                    color: Color(0xFF000000), fontSize: 14.sp, fontWeight: FontWeight.w700)),
            //backgroundColor: Colors.white,
          ),

        ],
      ),
    ),
    );
  }
}
