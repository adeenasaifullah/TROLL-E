import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/views/homescreen/homescreen.dart';

import '../../controller/profile_provider.dart';
import '../../utility.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late String username;


  @override
  void initState() {
    super.initState();

    context.read<ProfileProvider>().getUserProfile(context: context);

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final username = Provider.of<ProfileProvider>(context).user?.firstName.toCapitalized();
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          final gradient = RadialGradient(
            center: Alignment.center,
            radius: _animation.value,
            colors: [
              kPrimaryDarkColor,
              kPrimaryColor,
            ],
          );

          return Container(
            decoration: BoxDecoration(
              gradient: gradient,
            ),
            child: Center(
              child: Container(
                width: 300.0,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Wrap(
                    children: [Padding(
                      padding: const EdgeInsets.only(top:8,bottom: 8,left: 8),
                      child: Roboto_text_two(textValue: "Hi, ${username} " , size: 25.sp),
                    ),

                      SizedBox(height: 5,),
                      Padding(
                      padding: const EdgeInsets.only(top:8, left: 8,right: 8),
                      child: Roboto_text_two(textValue: 'We are so glad to have you here! The following screens will give a short demo on how you '
                            'can use our mobile app. Follow the instructions on each screen to have a smooth shopping experience. Enjoy!', size: 25.sp,
                      ),
                    ),
                    ]
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
