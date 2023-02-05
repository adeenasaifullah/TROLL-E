import 'package:flutter/material.dart';
import 'package:troll_e/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:troll_e/views/menu/menu.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _result = "";

   _scanQR() async {
    try {
       await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.QR).then((value)=>setState(()=> _result=value));
      // setState(() {
      //   _result = qrResult;
      // });
    }
    catch (ex) {
      setState(() {
        _result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar:true,
        drawer: Menu(),
      appBar:
      // PreferredSize(
      //   preferredSize: Size.fromHeight(80.0),
      //  child:
        AppBar(
            toolbarHeight: 80,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('Assets/images/TROLL-E-without-tagline.png', fit: BoxFit.cover, height: 180.h,)
        ])
         //   title:  Roboto_heading(textValue: 'Profile', size: 20.sp)

        ),
   //   ),
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
          child:  GestureDetector(
            onTap:()  => _scanQR() ,
            child: Container(
              height:150.h,
              width: 150.w,
              margin: EdgeInsets.all(100.0),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle
              ),
            ),
          )
          // Container(
          //   height:150.h,
          //   width: 150.w,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(200),
          //       color: kPrimaryColor,
              // boxShadow: [
              //   BoxShadow(
              //       color: kPrimaryColor,
              //       blurRadius: 80,
              //       spreadRadius: 20
              //   )
              // ]
           // ),
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
         // ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),

    );
  }
}
