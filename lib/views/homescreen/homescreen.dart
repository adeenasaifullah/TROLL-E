

import 'package:flutter/material.dart';
import 'package:troll_e/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:troll_e/views/menu/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
       //   title:  Roboto_heading(textValue: 'Profile', size: 20.sp)

      ),
      body: Container(
        width: double.infinity,

        decoration:  const BoxDecoration(
            gradient:  LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                kPrimaryColor,
               kPrimaryDarkColor,

              ],
            )

        ),
        child: Center(
          child: Container(
            height:150.h,
            width: 150.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                    color: kPrimaryColor,
                    blurRadius: 80,
                    spreadRadius: 20
                )
              ]
            ),
            // child: ElevatedButton(
            //
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.transparent,
            //     shape: CircleBorder(),
            //     padding: EdgeInsets.all(50),
            //     // <-- Splash color
            //   ),
            //     child: const Text("HomeScreen"),
            //   onPressed: () {  },
            // ),
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),

    );
  }
}
