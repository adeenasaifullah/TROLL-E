import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '/utility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:troll_e/views/menu/menu.dart';

class Helpcenter extends StatefulWidget {


  const Helpcenter({Key? key, })
      : super(key: key);

  @override
  _HelpcenterState createState() => _HelpcenterState();
}

class _HelpcenterState extends State<Helpcenter>{
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor:  Color(0xFFBAD3D4),
          centerTitle: true,
          title: Roboto_heading(textValue: 'Help Center', size: 20.sp),
        ),
        //body: Body(),
        // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10.h,),
            Row(
              children: <Widget>[
                SizedBox(width: 15.w,),
                helpquery(
                    'Assets/icons/cart.png',
                    'How to connect cart to the app?'),

              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              children: <Widget>[
                SizedBox(width: 15.w,),
                helpquery(
                    'Assets/icons/scan.png',
                    'Having trouble scanning a product'),

              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              children: <Widget>[
                SizedBox(width: 15.w,),

                  helpquery(
                      'Assets/icons/cart.png',
                      'How to remove product from cart?'),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              children: <Widget>[
                SizedBox(width: 15.w,),
                helpquery(
                    'Assets/icons/payment.png',
                    'Payment and Refund'),

              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              children: <Widget>[
                SizedBox(width: 15.w,),
                helpquery(
                    'Assets/icons/safety.png',
                    'Safety Concerns'),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              children: <Widget>[
                SizedBox(width: 15.w,),
                helpquery(
                    'Assets/icons/faq.png',
                    'FAQs'),
              ],
            ),
          ],
        )
    );
  }


  Widget helpquery(String image, String query) => Container(
    width: 340.w,
    height: 55.h,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.5.w, color: Color(0xFF838383)),
      ),
    ),

    child: Row(

      children: <Widget>[

        SizedBox(
          width: 286.w,
          height: 60.h,
          child: Row(
              children: <Widget>[

                Image.asset(
                  image,
                  height: 40.h,
                  width: 40.w,
                ),

                SizedBox(width: 10.w, ),

                //child: SizedBox(height: 10, ),
                Text(
                  query,
                  style: GoogleFonts.roboto(
                      fontSize: 13.sp,
                      color: const Color(0xff838383),
                      fontWeight: FontWeight.w400),
                ),
              ]
          ),
        ),
        // SizedBox(width: 100),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded, color: Color(0xff838383),),
          onPressed: (){}, )
      ],
    ),
  );
}