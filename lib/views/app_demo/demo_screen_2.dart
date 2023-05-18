import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../utility.dart';

class DemoScreenTwo extends StatefulWidget {
  @override
  _DemoScreenTwoState createState() => _DemoScreenTwoState();
}

class _DemoScreenTwoState extends State<DemoScreenTwo> {
  bool cartConnected = false;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 80.h,
            // ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Net Weight",
                        style: GoogleFonts.robotoCondensed(
                          color: const Color(0xFF779394),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: 60.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color:  const Color(0xFF779394),
                            width: 1.w,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "0",
                          style: GoogleFonts.robotoCondensed(
                            color: const Color(0xFF779394),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 35.w),
                  SizedBox(
                    height: 50.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(90.0, 50.0),
                        backgroundColor: const Color(0xff262626),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {


                      },
                      icon: (Image.asset('Assets/icons/scanner.png')),
                      label: const Text(''),
                    ),
                  ),
                  SizedBox(width: 35.w),
                  Column(
                    children: <Widget>[
                      Text(
                        "Total Cost",
                        style: GoogleFonts.robotoCondensed(
                          color: const Color(0xFF779394),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: 70.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xFF779394),
                            width: 1.w,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "PKR 0.00",
                          style: GoogleFonts.robotoCondensed(
                            color: const Color(0xFF779394),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),


            SizedBox(
              height: 35.h,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Roboto_subheading(textValue: "Add Product" , size: 18.sp),
                ],
              ),
            ),
            SizedBox(
                height: 20.h
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Padding(
                    padding: const EdgeInsets.only(left:15.0, right:15.0),
                    child: Roboto_text(textValue: 'Tap on the barcode scan icon to scan and add items to the cart', size: 16),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
