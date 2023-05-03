import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/utility.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/profile_provider.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final profileProvider = Provider.of<ProfileProvider>(context);
    final username = "${profileProvider.user?.firstName} ${profileProvider.user?.lastName}";
    return SizedBox(
      height: 150.h,
      //width: 80.w,
      child: Stack(
        // fit: StackFit.expand,
        // clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          coverImage(),
          Positioned(
            top: height * 0.03,
             // child: CircleAvatar(
             //    radius: 50,
             //    child: Image.file(
             //      File('/data/user/0/com.example.troll_e/cache/2180056f-cf97-42c0-91be-113177c71770/Screenshot_20230419-175151_Instagram.jpg'),
             //      // width: 100,
             //      // height: 100,
             //      fit: BoxFit.cover,
             //    ),
             //  ),
            // child: ClipOval(
            //     child: (imagePath != null)
            //     ? Image.file(File(imagePath!), width: 80.w,height: 85.h,)
            //
            //     : CircleAvatar(
            //   backgroundColor: Colors.grey,
            //   radius: 50,
            // )
            // ),
            // child: CircleAvatar(
            //   backgroundImage: Image.file(
            //     File("/data/user/0/com.example.troll_e/cache/2180056f-cf97-42c0-91be-113177c71770/Screenshot_20230419-175151_Instagram.jpg"),
            //     width: 100,
            //     height: 100,
            //     fit: BoxFit.cover,
            //   ),
            //   radius: 50,
              // child: imgXFile == null
              //     ? null
              //     : ClipRRect(
              //   borderRadius: BorderRadius.circular(50),
              //     child: Image.file(
              //     File("/data/user/0/com.example.troll_e/cache/2180056f-cf97-42c0-91be-113177c71770/Screenshot_20230419-175151_Instagram.jpg"),
              //     width: 100,
              //     height: 100,
              //     fit: BoxFit.cover,
              //   ),
              //),
           // ),
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                backgroundImage:
                    imgXFile == null ?  FileImage(
                      File("${profileProvider.user?.image}"))
                      //  File("/data/user/0/com.example.troll_e/cache/2180056f-cf97-42c0-91be-113177c71770/Screenshot_20230419-175151_Instagram.jpg"))
        : null
          )
          ),
          Positioned(
            right: width * 0.37,
            bottom: height * 0.07,
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
                child: const Image(
                  image: AssetImage("Assets/icons/camera.png"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 5),
            child: SizedBox(
              width: 150.w,
              child: Roboto_subheading(
                textValue: profileProvider.user?.firstName == null
                    ? ' '
                    : ' $username',
                size: 15.sp,
              ),
            ),
          ),
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
    // XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if(file !=null){
    //   imagePath= file.path;
    //   setState((){});
    // }
  }
}
