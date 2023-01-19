import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Signup.dart';
import '/utility.dart';


class LoginInputWrapper extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30,),
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
                      prefixIcon: Icon(Icons.email_sharp, color: Color(0xFF838383)),
                      autoFocus: false,
                    ),
                    SizedBox(height: displayHeight(context) * 0.03),
                    field(
                      validateInput: (password) {
                        if (passwordController.text.isEmpty) {
                          return "* Required";
                        }
                        if (password == null ) {
                          return "Incorrect Password";
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
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF838383)),
                      //suffixIcon: Icons.visibility_off,
                      //suffixIcon:  obscureIcon ? Icons.visibility : Icons.visibility_off,
                      autoFocus: false,
                      obscuredText: true,
                    ),

                  ]
              )
          ),
          SizedBox(height: displayHeight(context) * 0.01),
          Row(
              children: <Widget>[
                SizedBox(width: displayWidth(context) * 0.6),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ]
          ),
          SizedBox(height: displayHeight(context) * 0.06),
          NavButton(
            buttonText: 'Login',
            textSize: displayHeight(context) * 0.03,
            buttonHeight: displayHeight(context) * 0.065,
            buttonWidth: displayWidth(context) * 0.7,
            onPressed: ()=> {
              //do something
            },
          ),
          SizedBox(height: displayHeight(context) * 0.04),
          Text(
            "Or continue with",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: displayHeight(context) * 0.01),

          Image(image: AssetImage('Assets/google.png')),
          SizedBox(height: displayHeight(context) * 0.02),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Signup()));
            },
            child: Text("Don't have an account? Sign up",
                style: GoogleFonts.robotoCondensed(
                    color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.w700)),
            //backgroundColor: Colors.white,
          ),

        ],
      ),
    );
  }
}