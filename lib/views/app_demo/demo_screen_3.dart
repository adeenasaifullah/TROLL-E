import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../utility.dart';

class DemoScreenThree extends StatefulWidget {
  @override
  _DemoScreenThreeState createState() => _DemoScreenThreeState();
}

class _DemoScreenThreeState extends State<DemoScreenThree> {
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
            Padding(
              padding: const EdgeInsets.only(left:35.0),
              child: Container(child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Roboto_subheading(textValue: "Rescan Product", size: 12),
                ],
              )),
            ),
            SizedBox(height:5),
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
              height:35.h
            ),

            //ALERT DIALOG
            Padding(
              padding: const EdgeInsets.only(left:35.0),
              child: Container(child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Roboto_subheading(textValue: "Select an option", size: 12),
                ],
              )),
            ),
            SizedBox(height:5),
      AlertDialog(
        title: const Text(
          'What would you like to do?',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        content: const Text(
          "Do you want to increase or decrease the item quantity?",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF000000),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal:15.w),
                    textStyle:  TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ),

                            onPressed: ()  {

                  },
                  child: const Text('Increase'),
                ),
                SizedBox(width: 16.w),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color(0xFF000000),
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal:15.w),
                    textStyle:  TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  onPressed: () async {

                  },
                  child: const Text('Decrease'),
                ),
              ],
            ),
          ),
        ],
      ),


            SizedBox(
              height: 35.h,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Roboto_subheading(textValue: "Increase or Decrease Quantity" , size: 18.sp),
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
                    child: Roboto_text(textValue: 'To increase or decrease the quantity rescan the same product and choose the option to increase or decrease.', size: 16),
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
