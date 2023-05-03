import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/views/login_signup/login.dart';
import 'package:troll_e/views/login_signup/profile_image.dart';
import '../../controller/user_provider.dart';
import '../../helpers/user_apis.dart';
import '/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupInputWrapper extends StatelessWidget {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  static final _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool result;
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: displayHeight(context) * 0.01),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          field(
                            validateInput: (name) {
                              if (fnameController.text.isEmpty) {
                                return "* Required";
                              } else {
                                return null;
                              }
                            },
                            // onChanged: (val) {
                            //   setState(() => email = val);
                            // },
                            textController: fnameController,
                            labelText: 'First Name',
                            //hintText: 'email',

                            autoFocus: false,
                          ),
                          SizedBox(height: displayHeight(context) * 0.02),
                          field(
                            validateInput: (name) {
                              if (lnameController.text.isEmpty) {
                                return "* Required";
                              } else {
                                return null;
                              }
                            },
                            // onChanged: (val) {
                            //   setState(() => email = val);
                            // },
                            textController: lnameController,
                            labelText: 'Last Name',
                            //hintText: 'email',

                            autoFocus: false,
                          ),
                          SizedBox(height: displayHeight(context) * 0.02),
                          field(
                            validateInput: (email) {
                              if (emailController.text.isEmpty) {
                                return "* Required";
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email!)) {
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

                            autoFocus: false,
                          ),
                          SizedBox(height: displayHeight(context) * 0.02),
                          field(
                            validateInput: (phone) {
                              if (phone!.isEmpty) {
                                return "* Required";
                              } else if (!RegExp(r'^[0-9]{11}$')
                                  .hasMatch(phone)) {
                                //  r'^[0-9]{10}$' pattern plain match number with length 11
                                return "Enter correct phone number";
                              } else {
                                return null;
                              }
                            },
                            // onChanged: (val) {
                            //   setState(() => email = val);
                            // },
                            textController: phoneController,
                            labelText: 'Phone Number',
                            //hintText: 'email',

                            autoFocus: false,
                          ),
                          SizedBox(height: displayHeight(context) * 0.02),
                          passfield(
                            validateInput: (password) {
                              if (password == null || password.isEmpty) {
                                return "* Required";
                              }
                              if (password.length < 7) {
                                return "Password must be at least 8 characters long.";
                              } else {
                                return null;
                              }
                            },

                            // onChanged: (val) {
                            //   setState(() => password = val);
                            // },
                            textController: passwordController,
                            labelText: 'Password',
                            //hintText: 'Enter your password',

                            suffixIcon: Icons.visibility_off,
                            //suffixIcon:  obscureIcon ? Icons.visibility : Icons.visibility_off,
                            autoFocus: false,
                          ),
                          SizedBox(height: displayHeight(context) * 0.02),
                          passfield(
                            validateInput: (cpassword) {
                              if (cpassword == null || cpassword.isEmpty) {
                                return "* Required";
                              }
                              if (cpassword != confirmController.text) {
                                return 'Passwords do not match.';
                              } else {
                                return null;
                              }
                            },
                            textController: confirmController,
                            labelText: 'Confirm Password',
                            suffixIcon: Icons.visibility_off,
                            //suffixIcon:  obscureIcon ? Icons.visibility : Icons.visibility_off,
                            autoFocus: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: displayHeight(context) * 0.04),
                    NavButton(
                      buttonText: 'Sign Up',
                      textSize: 20.sp,
                      buttonHeight: displayHeight(context) * 0.075,
                      buttonWidth: displayWidth(context) * 0.8,
                      onPressed: () async {
                        if (_signUpFormKey.currentState!.validate()) {
                          // result = await userProvider.SignupUser(
                          //     context: context,
                          //     firstName: fnameController.text,
                          //     lastName: lnameController.text,
                          //     email: emailController.text,
                          //     phoneNumber: phoneController.text,
                          //     password: passwordController.text);
                          // print(result);
                          // if (result == (true)) {
                             Navigator.of(context).pushReplacement(MaterialPageRoute(
                                 builder: (context) =>  ProfileImage(fname: fnameController.text,
                                   lname: lnameController.text,
                                   email: emailController.text,
                                   phone: phoneController.text,
                                   password: passwordController.text,
                                 )));
                          // }
                        }
                      },
                    ),
                    SizedBox(height: displayHeight(context) * 0.0084),
                    //Roboto_text(textValue: 'Already have an account?', size: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Login()));
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF000000),
                          fontSize: 15.sp,
                        ),
                      ),
                      //backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
