
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:troll_e/utility.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);


  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  XFile? imgXFile;
  final ImagePicker imagePicker=ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      //width: 80.w,
      child: Stack(
        // fit: StackFit.expand,
        // clipBehavior: Clip.none,
          alignment: Alignment.center,
        children: [
          CoverImage(),
          Positioned(
            top: 20,
            // child: ClipOval(
            //     child: (imagePath != null)
            //     ? Image.file(File(imagePath!), width: 80.w,height: 85.h,)
            //
            //     : CircleAvatar(
            //   backgroundColor: Colors.grey,
            //   radius: 50,
            // )
            // ),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 50,
              backgroundImage: imgXFile == null ? null : FileImage(File(imgXFile!.path))
            ),
          ),
          Positioned(
            right:150,
            bottom: 50,
            child: SizedBox(
              height: 30.h,
              width: 30.w,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  //  side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: kPrimaryColor.withOpacity(0.8),
                ),
                onPressed: () {
                  pickMedia();
                },
              child:
              Image(image: AssetImage("Assets/icons/camera.png"))
              ),
            ),
          ),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 120, 20, 5),
        child: SizedBox(width: 150.w,
          child: Roboto_subheading(textValue: "Prince William Mountbatten ",size: 15.sp,),)
      )
        ],
      ),
    );
  }

  Widget CoverImage()=>
      Container(
        child: Image.asset("Assets/images/cover_photo.png",
          width: double.infinity,
          height: 300.h,
          fit:BoxFit.cover,
        )
      );

  void pickMedia() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
    // XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if(file !=null){
    //   imagePath= file.path;
    //   setState((){});
    // }
  }
}
