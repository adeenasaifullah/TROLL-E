import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/controller/user_provider.dart';
import 'package:troll_e/views/profile/change_password.dart';
import 'package:troll_e/views/profile/profile_picture.dart';

import '../../controller/profile_provider.dart';
import '../../helpers/user_apis.dart';
import '../../models/user_model.dart';
import '../../utility.dart';
import '../menu/menu.dart';
import 'edit_card_details.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobnum = TextEditingController();

  @override
  void initState() {
    //super.initState();
    Provider.of<ProfileProvider>(context, listen: false)
        .getUserProfile(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    print("INSIDE PROFILE DETAIL SCREEEN !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: profileProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          const ProfilePic(),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    REdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // ProfilePic(),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Name(
                                        heading: "First Name",
                                        image: 'Assets/icons/user.png',
                                        cont: fname,
                                        initValue:
                                            profileProvider.user?.firstName!),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Name(
                                        heading: "Last Name",
                                        image: 'Assets/icons/user.png',
                                        cont: lname,
                                        initValue:
                                        profileProvider.user?.lastName!),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Email(
                                        heading: "Email",
                                        image: 'Assets/icons/email.png',
                                        cont: email,
                                        initValue:
                                            profileProvider.user?.email!),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    MobileNumber(
                                        heading: "Mobile Number",
                                        image: 'Assets/icons/mobilenumber.png',
                                        cont: mobnum,
                                        initValue:
                                            profileProvider.user?.phoneNumber!),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    //CHANGE PASSWORD
                                    GestureDetector(
                                      onTap: () {
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (BuildContext context) =>
                                        //       ChangePassword(context),
                                        // );
                                      },
                                      child: Container(
                                        width: 400.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          //.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10.0.r),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 2.0,
                                              // soften the shadow
                                              spreadRadius: 2.0,
                                              //extend the shadow
                                              offset: Offset(
                                                1.0,
                                                // Move to right 5  horizontally
                                                2.0, // Move to bottom 5 Vertically
                                              ),
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: REdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 2.h,
                                          ),
                                          child: SizedBox(
                                            height: 30.h,
                                            //   width: 10.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20.h,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: REdgeInsets
                                                            .fromLTRB(
                                                                6, 5, 3, 0),
                                                        child: Image.asset(
                                                          'Assets/icons/lock.png',
                                                          height: 45.h,
                                                          width: 20.w,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: REdgeInsets
                                                            .fromLTRB(
                                                                0, 5, 0, 0),
                                                        child:
                                                            Roboto_subheading(
                                                                textValue:
                                                                    "Password",
                                                                size: 15.sp),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Padding(
                                                  padding: REdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Text(
                                                    "*******",
                                                    style: TextStyle(
                                                      // decoration: TextDecoration.underline,
                                                      // decorationColor: Colors.black,
                                                      // decorationThickness: 1,

                                                      fontFamily: "Roboto",
                                                      fontSize: 15.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    //Card Details.
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     Navigator.of(context).push(
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const EditCardDetails(),
                                    //       ),
                                    //     );
                                    //   },
                                    //   child: Container(
                                    //     width: 400.w,
                                    //     height: 80.h,
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       //.withOpacity(0.3),
                                    //       borderRadius:
                                    //           BorderRadius.circular(10.0.r),
                                    //       boxShadow: const [
                                    //         BoxShadow(
                                    //           color: Colors.black12,
                                    //           blurRadius: 2.0,
                                    //           // soften the shadow
                                    //           spreadRadius: 2.0,
                                    //           //extend the shadow
                                    //           offset: Offset(
                                    //             1.0,
                                    //             // Move to right 5  horizontally
                                    //             2.0, // Move to bottom 5 Vertically
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //     child: Padding(
                                    //       padding: REdgeInsets.symmetric(
                                    //           horizontal: 10.w, vertical: 2.h),
                                    //       child: SizedBox(
                                    //         height: 30.h,
                                    //         //   width: 10.w,
                                    //         child: Column(
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.start,
                                    //           children: [
                                    //             SizedBox(
                                    //               height: 20.h,
                                    //               child: Row(
                                    //                 children: [
                                    //                   Padding(
                                    //                     padding: REdgeInsets
                                    //                         .fromLTRB(
                                    //                             6, 5, 3, 0),
                                    //                     child: Image.asset(
                                    //                       'Assets/icons/creditcard.png',
                                    //                       height: 45.h,
                                    //                       width: 20.w,
                                    //                     ),
                                    //                   ),
                                    //                   Padding(
                                    //                       padding: REdgeInsets
                                    //                           .fromLTRB(
                                    //                               0, 5, 0, 0),
                                    //                       child: Roboto_subheading(
                                    //                           textValue:
                                    //                               "Card Details",
                                    //                           size: 15.sp))
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //             SizedBox(height: 13.h),
                                    //             Padding(
                                    //               padding: REdgeInsets.fromLTRB(
                                    //                   10, 0, 0, 0),
                                    //               child: Text(
                                    //                 "xxxx-xxxx-xxxx-3452",
                                    //                 style: TextStyle(
                                    //                     fontFamily: "Roboto",
                                    //                     fontSize: 14.sp,
                                    //                     fontWeight:
                                    //                         FontWeight.normal),
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    //Padding(
                                    //   padding:  EdgeInsets.fromLTRB(
                                    //       1, 15.h, 1, 20.h),
                                    //   child: NavButton(
                                    //     buttonText: 'Save Changes',
                                    //     textSize: 20.sp,
                                    //     buttonHeight: 50.h,
                                    //     buttonWidth: 320.w,
                                    //     onPressed: () => {
                                    //       //do something
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget Name({image, heading, cont, initValue}) {
    return Container(
        width: 400.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          //.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10.0.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: Offset(
                1.0, // Move to right 5  horizontally
                2.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          child: SizedBox(
              height: 30.h,
              //   width: 10.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      children: [
                        Padding(
                          padding: REdgeInsets.fromLTRB(6, 5, 3, 0),
                          child: Image.asset(
                            image,
                            height: 45.h,
                            width: 20.w,
                          ),
                        ),
                        Padding(
                            padding: REdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Roboto_subheading(
                                textValue: heading, size: 15.sp))
                      ],
                    ),
                  ),
                  TextFormField(
                    enabled : false,
                    decoration: InputDecoration(
                      contentPadding: REdgeInsets.symmetric(
                          vertical: 0.h, horizontal: 10.w),
                    ),
                    controller: cont..text = initValue,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Roboto"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                ],
              )),
        ));
  }

  Widget Email({image, heading, cont, initValue}) {
    return Container(
        width: 400.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          //.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10.0.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: Offset(
                1.0, // Move to right 5  horizontally
                2.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          child: SizedBox(
              height: 30.h,
              //   width: 10.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      children: [
                        Padding(
                          padding: REdgeInsets.fromLTRB(6, 6, 3, 0),
                          child: Image.asset(
                            image,
                            height: 42.h,
                            width: 20.w,
                          ),
                        ),
                        SizedBox(height: 0.h),
                        Padding(
                            padding: REdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Roboto_subheading(
                                textValue: heading, size: 15.sp))
                      ],
                    ),
                  ),
                  TextFormField(
                    enabled : false,
                    decoration: InputDecoration(
                      contentPadding: REdgeInsets.symmetric(
                          vertical: 0.h, horizontal: 10.w),
                    ),
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Roboto"),
                    controller: cont..text = initValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!RegExp(
                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please enter a valid email");
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                ],
              )),
        ));
  }

  Widget MobileNumber({image, heading, cont, initValue}) {
    return Container(
        width: 400.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          //.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10.0.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: Offset(
                1.0, // Move to right 5  horizontally
                2.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          child: SizedBox(
              height: 30.h,
              //   width: 10.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      children: [
                        Padding(
                          padding: REdgeInsets.fromLTRB(6, 6, 3, 0),
                          child: Image.asset(
                            image,
                            height: 42.h,
                            width: 20.w,
                          ),
                        ),
                        SizedBox(width: 0),
                        Padding(
                            padding: REdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Roboto_subheading(
                                textValue: heading, size: 15.sp))
                      ],
                    ),
                  ),
                  TextFormField(
                    enabled : false,
                    decoration: InputDecoration(
                      contentPadding:
                          REdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                    ),
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Roboto"),
                    controller: cont..text = initValue,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (value.length != 11) {
                        return "Please enter a valid Mobile Number";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                ],
              )),
        ));
  }

  // Widget ChangePassword(BuildContext context) {
  //   TextEditingController currentpw = TextEditingController();
  //   TextEditingController newpw = TextEditingController();
  //   TextEditingController confirmpw = TextEditingController();
  //   return AlertDialog(
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(8.0))),
  //     // title: const Text('Popup example'),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         TextFormField(
  //           decoration: const InputDecoration(
  //             hintText: 'Current Password',
  //           ),
  //           controller: currentpw,
  //           validator: (value) {
  //             if (value == null || value.isEmpty) {
  //               return 'This field is required';
  //             }
  //             return null;
  //           },
  //           obscureText: true,
  //         ),
  //         SizedBox(height: 10.h),
  //
  //         TextFormField(
  //           decoration: const InputDecoration(
  //             hintText: 'New Password',
  //           ),
  //           controller: newpw,
  //           validator: (value) {
  //             if (value == null || value.isEmpty) {
  //               return 'This field is required';
  //             }
  //             return null;
  //           },
  //           obscureText: true,
  //         ),
  //         SizedBox(height: 10.h),
  //
  //         TextFormField(
  //           decoration: const InputDecoration(
  //             hintText: 'Confirm Password',
  //           ),
  //           controller: confirmpw,
  //           validator: (value) {
  //             if (value == null || value.isEmpty) {
  //               return 'This field is required';
  //             }
  //             if (value != newpw) {
  //               return 'Passwords do not match';
  //             }
  //             return null;
  //           },
  //           obscureText: true,
  //         ),
  //
  //         Padding(
  //           padding: EdgeInsets.fromLTRB(1, 15, 1, 10),
  //           child: NavButton(
  //             buttonText: 'Save Changes',
  //             textSize: 20.sp,
  //             buttonHeight: 50.h,
  //             buttonWidth: 320.w,
  //             onPressed: () => {
  //               //do something
  //             },
  //           ),
  //         )
  //         // SizedBox(height: 20.h,),
  //         // ElevatedButton(
  //         //     onPressed: () {
  //         //       Navigator.of(context).pop();
  //         //     },
  //         //     child: const Text('Save Changes'),
  //         //     style: ElevatedButton.styleFrom(
  //         //         primary: Colors.black,
  //         //         shape: RoundedRectangleBorder(
  //         //           borderRadius: BorderRadius.circular(12), // <-- Radius
  //         //         ),
  //         //         padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
  //         //         textStyle: TextStyle(
  //         //             fontSize: 15.sp,
  //         //             fontWeight: FontWeight.bold))
  //         // )
  //       ],
  //     ),
  //   );
  // }
}
