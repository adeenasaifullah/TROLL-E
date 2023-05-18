import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/views/forgot_password/change_password.dart';
import 'package:troll_e/views/forgot_password/forgot_password.dart';
import '../../controller/user_provider.dart';
import '../../helpers/user_apis.dart';
import '../forgot_password/token_verification.dart';
import '../homescreen/homescreen.dart';
import 'Signup.dart';
import '/utility.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class LoginInputWrapper extends StatefulWidget {
  const LoginInputWrapper({super.key});

  @override
  _LoginInputWrapperState createState() => _LoginInputWrapperState();
}

class _LoginInputWrapperState extends State<LoginInputWrapper> {
  //late SharedPreferences prefs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId: '495548594516-93cme11jghhar4msjn4d0oe1jai7suuq.apps.googleusercontent.com',
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  initSharedPref();
  }

  // void initSharedPref() async{
  //   prefs = await SharedPreferences.getInstance();
  //   print("THIS IS PREFS VALUE IN INITSHAREDPREF OF LOGINWRAPPER SCREEEN");
  //   print(prefs.get('accesstoken'));
  // }

  // Future<Map<String, dynamic>> verifyIdToken(String idToken) async {
  //   final url = 'http://localhost:3000/google/login'; // Replace with your backend server URL
  //   final response = await http.post(Uri.parse(url), body: {'idToken': idToken});
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return data;
  //   } else {
  //     throw Exception('Failed to verify ID token');
  //   }
  // }

  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _loginFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: displayHeight(context) * 0.02),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                            // prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF838383)),
                            autoFocus: false,
                          ),
                          SizedBox(height: displayHeight(context) * 0.03),
                          passfield(
                            validateInput: (password) {
                              if (passwordController.text.isEmpty) {
                                return "* Required";
                              }
                              if (password == null) {
                                return "Incorrect Password";
                              } else {
                                return null;
                              }
                            },

                            textController: passwordController,
                            labelText: 'Password',
                            suffixIcon: Icons.visibility_off,
                            autoFocus: false,
                            // obscuredText: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: displayHeight(context) * 0.01),
                    Row(
                      children: <Widget>[
                        SizedBox(width: displayWidth(context) * 0.4),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: displayHeight(context) * 0.04),
                    NavButton(
                      buttonText: 'Login',
                      textSize: 20.sp,
                      buttonHeight: displayHeight(context) * 0.075,
                      buttonWidth: displayWidth(context) * 0.8,
                      onPressed: () async {
                        if (_loginFormKey.currentState!.validate())  {
                          await userProvider.loginUser(context: context, email: emailController.text, password: passwordController.text);
                        //  await loginUser()
                          // await login(
                          //     userProvider: userProvider,
                          //     context: context,
                          //     email: emailController.text,
                          //     password: passwordController.text);

                          print(
                              "result in login_input wrapper screeennnnnn.................");
                          // print(value);
                          //print(userProvider.prefs.getString('accesstoken'));
                         //  //if(value != false){
                         //  userProvider.prefs =
                         //      await SharedPreferences.getInstance();
                         // print(userProvider.prefs.get('accesstoken'));

                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          if (prefs.getString('accesstoken') !=
                              null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  token: prefs.getString("accesstoken"),
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: displayHeight(context) * 0.04),
                    Text(
                      "Or continue with",
                      style: TextStyle(color: Colors.black, fontSize: 15.sp),
                    ),
                    SizedBox(height: displayHeight(context) * 0.01),

                    InkWell(
                      child: Image(
                        image: const AssetImage('Assets/images/google.png'),
                        height: displayHeight(context) * 0.1,
                        width: displayWidth(context) * 0.1,
                      ),
                      onTap: () async {

                        // String googleAuthUrl = 'http://localhost:3000/auth/google?redirect_uri=troll-e://google-auth-success';
                        // String? result = await FlutterWebAuth.authenticate(
                        //   url: googleAuthUrl,
                        //   callbackUrlScheme: 'troll-e',
                        // );
                        //
                        // if (result != null) {
                        //   Navigator.pushNamed(
                        //     context,
                        //     'troll-e://google-auth-success?code=$result',
                        //     arguments: googleAuthUrl,
                        //   );
                        // }
                        // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                        // final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
                        // final String? idToken = googleAuth.idToken;


                        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                        if (googleUser != null) {
                          print(googleUser);
                          print(googleUser.displayName);

                          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                          // print(googleAuth.);
                          // final String? idToken = googleAuth.idToken;
                          //  print("id token from my google usez $idToken");


                        final user = await googleLogIn(email: googleUser.email, name: googleUser.displayName,
                            photourl: googleUser.photoUrl, googleid: googleUser.id,context: context, userProvider: userProvider);
                        print(user);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                        print('Access token from backend: ${prefs.getString('accesstoken')}');
                        if (prefs.getString('accesstoken') !=
                            null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                token: prefs
                                    .getString("accesstoken"),
                              ),
                            ),
                          );
                        }
                      }},


                    ),
                    //SizedBox(height: displayHeight(context) * 0.02),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "Don't have an account? Sign up",
                        style: GoogleFonts.robotoCondensed(
                            color: const Color(0xFF000000),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700),
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
