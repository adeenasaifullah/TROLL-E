import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/helpers/user_apis.dart';
import 'package:troll_e/utility.dart';
import 'package:troll_e/views/login_signup/login.dart';
import 'package:troll_e/views/profile/profile_details.dart';

import '../../controller/profile_provider.dart';
import '../../models/shopping_history.dart';
import '../help_center/help_center.dart';
import '../homescreen/homescreen.dart';
import '../shopping_history/shopping_history.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    final username = profileProvider.user?.firstName.toCapitalized();
    final lastname = profileProvider.user?.lastName.toCapitalized();
    final email = profileProvider.user?.email;

    final initials = username![0]+lastname![0];
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              profileProvider.user?.firstName == null ? ' ' : ' $username',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            accountEmail: Text(
              profileProvider.user?.firstName == null ? ' ' : ' $email',
              style: const TextStyle(color: Colors.black),
            ),
            currentAccountPicture:
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 50,
              backgroundImage: profileProvider.user?.image != null
                  ? FileImage(File("${profileProvider.user?.image}"))
                  : null,
              // Set backgroundImage to null if image path is null

                          ),

            //         CircleAvatar(
    //     backgroundColor: Colors.grey,
    //     radius: 50,
    //     backgroundImage:
    //            FileImage(
    //               File("${profileProvider.user?.image}"))
    //
    // ),
            // CircleAvatar(
            //   child: ClipOval(
            //
               // child: Text(initials)
                // Image.asset(
                //   "name",
                //   width: 90.w,
                //   height: 90.h,
                //   fit: BoxFit.cover,
                // ),
            //   ),
            // ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kPrimaryDarkColor,
                  kPrimaryColor,
                  Colors.white,
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ),
          ),

          // Divider(
          //   color: Color(0xFF838383),
          //   height: 5,
          //   thickness: 1,
          //     indent: 20,
          //   endIndent: 20,
          // ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text("Profile"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfileDetails(),
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.history_outlined),
              title: const Text("Shopping History"),
              onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShoppingHistory())),
              ),
          ListTile(
            leading: const Icon(Icons.help_outline_outlined),
            title: const Text("Help Center"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Helpcenter(),
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () => {
                    logout(context),
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ), (Route<dynamic> route) => false
                    ),
                  })
        ],
      ),
    );
  }
}
