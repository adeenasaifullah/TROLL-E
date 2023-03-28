

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:troll_e/views/homescreen/homescreen.dart';
import 'package:troll_e/views/login_signup/signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin  {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync: this, duration: Duration(seconds: 2),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);

    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Signup()
            )

      );
       }
      // else if(status == AnimationStatus.dismissed){
      //   animation.forward();
      // }
    });
    animation.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FadeTransition(
            opacity: _fadeInFadeOut,
            child: Image(image: AssetImage('Assets/images/TROLL-E.png'))
          ),
        ),
      ),
    );
    // return Container(
    //     color: Colors.white,
    //     child:Image(image: AssetImage('Assets/images/TROLL-E.png'))
    // );
  }
}
