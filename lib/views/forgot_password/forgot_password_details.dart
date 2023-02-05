
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:troll_e/utility.dart';
import '../login_signup/Signup.dart';

class ForgotPasswordDetails extends StatefulWidget {
  const ForgotPasswordDetails({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordDetails> createState() => _ForgotPasswordDetailsState();
}

class _ForgotPasswordDetailsState extends State<ForgotPasswordDetails> {

  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
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
            onPressed: ()=> {
              //do something
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
    );
  }
}
