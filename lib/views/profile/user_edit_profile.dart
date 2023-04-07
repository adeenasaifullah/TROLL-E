import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:troll_e/utility.dart';
import 'package:troll_e/views/menu/menu.dart';
import 'package:troll_e/views/profile/profile_details.dart';

// import 'package:testtrolle/body.dart';
// import 'package:testtrolle/menu.dart';
// import 'package:troll_e/constants.dart';
// import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const Menu(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: kPrimaryColor,
        title: Roboto_heading(textValue: 'Profile', size: 20.sp),
      ),
      body: const ProfileDetails(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
