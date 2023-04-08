import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:troll_e/utility.dart';

class ProfileImageWrapper extends StatefulWidget {
  const ProfileImageWrapper({Key? key}) : super(key: key);

  @override
  State<ProfileImageWrapper> createState() => _ProfileImageWrapperState();
}

class _ProfileImageWrapperState extends State<ProfileImageWrapper> {
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
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
                  foregroundColor: Colors.white,
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
    setState(() {
      imgXFile;
    });
  }
}
