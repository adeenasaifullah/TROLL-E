import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/views/login_signup/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:troll_e/utility.dart';
import '../../controller/user_provider.dart';
import 'profile_image_wrapper.dart';

class ProfileImage extends StatefulWidget {

final  fname;
final  lname;
final  email;
final  phone;
final password;



const ProfileImage({Key? key, required this.fname, required this.lname, required this.email,
  required this.phone, required this.password }) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    File xfile;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            // gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            //   Color(0xFFBAD3D4),
            //   Color(0xFFBAD3D4),
            //   // Color(0xFFBAD3D4),
            // ]),
            color: kPrimaryColor),
        child: Column(
          children: <Widget>[
            SizedBox(height: displayHeight(context) * 0.07),
            Roboto_heading(textValue: 'Set Profile Image', size: 26.sp),
            SizedBox(height: displayHeight(context) * 0.01),
            Roboto_subheading(
                textValue: 'Select an image to set profile picture',
                size: 14.sp),
            SizedBox(
              height: displayHeight(context) * 0.1,
            ),
            //Header(),
            Expanded(
              child: Container(
                height: displayHeight(context) * 0.2,
                width: displayWidth(context),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )),
                child: Column(
                  children: <Widget>[
                SizedBox(
                height: 350.h,
                  //width: 80.w,
                  child: Stack(
                    // fit: StackFit.expand,
                    // clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // CoverImage(),
                      Positioned(
                        top: height * 0.12,
                        child: CircleAvatar(
                          backgroundColor: kPrimaryDarkColor,
                          radius: 110,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 106,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 100,
                              backgroundImage: imgXFile == null
                                  ? null
                                  : FileImage(
                                File(imgXFile!.path),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: width * 0.3,
                        top: height * 0.35,
                        child: SizedBox(
                          height: 35.h,
                          width: 35.w,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              // foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                //  side: BorderSide(color: Colors.white),
                              ),
                              backgroundColor: kPrimaryColor.withOpacity(0.8),
                            ),
                            onPressed: () {
                              pickMedia();
                            },
                            child: const Image(
                              image: AssetImage("Assets/icons/camera.png"),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: width * 0.38,
                        top: height * 0.45,
                        child: GestureDetector(
                          onTap: () {
                            pickMedia();
                          },
                          child: const Text(
                            "Choose Image",
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                    SizedBox(
                      height: 10.h,
                    ),
                    NavButton(
                      buttonText: 'Done',
                      textSize: 20.sp,
                      buttonHeight: displayHeight(context) * 0.075,
                      buttonWidth: displayWidth(context) * 0.8,
                      onPressed: () async {
                          if(imgXFile!=null){
                              xfile=File(imgXFile!.path);
                              bool result = await userProvider.SignupUser(
                              context: context,
                              firstName: widget.fname ,
                              lastName: widget.lname,
                              email: widget.email,
                              phoneNumber: widget.phone,
                              password: widget.password,
                              imagefile: xfile
                              );

                               if (result == (true)) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => Login()
                                 )
                              );
                              }


                          }
                        //do something
                      },
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 45.w,
                        child: TextButton(
                          onPressed: () async {
                            bool result = await userProvider.SignupUser(
                                context: context,
                                firstName: widget.fname ,
                                lastName: widget.lname,
                                email: widget.email,
                                phoneNumber: widget.phone,
                                password: widget.password,
                            );

                            if (result == (true)) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => Login()
                              )
                              );
                            }
                          },
                          child: Text(
                            "Skip",
                            style: GoogleFonts.robotoCondensed(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          //backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget coverImage() => Image.asset(
    "Assets/images/cover_photo.png",
    width: double.infinity,
    height: 300.h,
    fit: BoxFit.cover,
  );

  void pickMedia() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    print("THIS IS IMGXFILE ");
    print(imgXFile);

    print(File(imgXFile!.path));
    print(imgXFile.toString());

    setState(() {
      imgXFile;
    });
  }
  // void pickMedia() async {
  //   imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     imgXFile;
  //   });
  // }
}
