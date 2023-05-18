import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../utility.dart';

class DemoScreenFour extends StatefulWidget {
  @override
  _DemoScreenFourState createState() => _DemoScreenFourState();
}

class _DemoScreenFourState extends State<DemoScreenFour> {
  bool cartConnected = false;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, top: 8, right: 8, bottom: 8),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 73.h,
                              width: 73.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(
                                        "https://cdn.shopify.com/s/files/1/0522/2357/4165/products/S_u_r_f__E_x_c_e_l__W_a_s_h_i_n_g__P_o_w_d_e_r__1_7_0_G_M__2100001987.jpg?v=1638625084")),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Surf Excel",
                                  style:
                                  GoogleFonts.robotoCondensed(
                                      fontWeight:
                                      FontWeight.bold)),
                              SizedBox(height: 4.h),
                              Text(
                                "Surf Excel 500g",
                                style:
                                GoogleFonts.robotoCondensed(
                                  color: const Color(0xFF779394),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "PKR 650",
                                    style: GoogleFonts
                                        .robotoCondensed(
                                      color: Colors.black54,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 100.w,
                                    height: 27.h,
                                    decoration: BoxDecoration(

                                      borderRadius:
                                      BorderRadius.circular(
                                          15),
                                      border: Border.all(
                                        color: const Color(
                                            0xFF779394),
                                        width: 0.5.w,
                                      ),
                                    ),
//alignment: Alignment.center,
                                    child: Expanded(
                                      child: Row(
//crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              icon: const Icon(Icons.remove_circle, color: Color(0xFF779394), size: 16),
                                              onPressed: () async {}
                                          ),

                                          Text(
                                            "1",
                                            style: GoogleFonts
                                                .robotoCondensed(
                                              color: const Color(
                                                  0xFF779394),
                                              fontSize: 13.sp,
                                              fontWeight:
                                              FontWeight.w400,
                                            ),
                                          ),

                                          IconButton(
                                            icon: const Icon(
                                                Icons.add_circle,
                                                color: Color(
                                                    0xFF779394),
                                                size: 16),
                                            onPressed: ()  {

                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
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
                    child: Roboto_text(textValue: 'You can also increase or decrease the quantity by simply clicking + or - and rescaning the barcode', size: 16),
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
