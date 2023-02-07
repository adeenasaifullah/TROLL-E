import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:troll_e/views/login_signup/login.dart';
import '/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_image_wrapper.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  XFile? imgXFile;
  final ImagePicker imagePicker=ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          //   Color(0xFFBAD3D4),
          //   Color(0xFFBAD3D4),
          //   // Color(0xFFBAD3D4),
          // ]),
            color: kPrimaryColor
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: displayHeight(context) * 0.07),
            Roboto_heading(textValue: 'Set Profile Image', size: 26.sp),
            SizedBox(height: displayHeight(context) * 0.01),
            Roboto_subheading(textValue: 'Select an image to set profile picture', size: 14.sp),
            SizedBox(height: displayHeight(context) * 0.1,),
            //Header(),
            Expanded(child: Container(
                height: displayHeight(context)*0.2,
                width: displayWidth(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )
                ),
                child: Column(
                    children: <Widget>[
                      ProfileImageWrapper(),
                      SizedBox(height: 10.h,),
                      NavButton(
                        buttonText: 'Done',
                        textSize: 20.sp,
                        buttonHeight: displayHeight(context)*0.075,
                        buttonWidth: displayWidth(context) * 0.8,
                        onPressed: ()=> {
                          //do something
                        },
                      ),
                      SizedBox(height: 60.h,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 45.w,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()));
                          },
                          child: Text("Skip",
                              style: GoogleFonts.robotoCondensed( fontStyle: FontStyle.italic,
                                  color: Colors.grey, decoration: TextDecoration.underline,)),
                          //backgroundColor: Colors.white,
                        ),
                        ),
                    )

                    ]
                )
            ))
          ],
        ),
      ),
    );
  }

  void pickMedia() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });

  }
}

