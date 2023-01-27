

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:troll_e/utility.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("William Windsor", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
            accountEmail: Text("William@gmail.com", style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("name",
                  width: 90.w,
                  height: 90.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration:  const BoxDecoration(
                gradient:  LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kPrimaryColor,
                    kPrimaryColor,
                    Colors.white,
                  ],
                )

            ),

          ),
          ListTile(
            leading: Icon(Icons.home_outlined) ,
            title: Text("Home"),
            onTap: ()=> null,),

          // Divider(
          //   color: Color(0xFF838383),
          //   height: 5,
          //   thickness: 1,
          //     indent: 20,
          //   endIndent: 20,
          // ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined) ,
            title: Text("Profile"),
            onTap: ()=> null,),
          ListTile(
            leading: Icon(Icons.history_outlined) ,
            title: Text("Shopping History"),
            onTap: ()=> null,),
          ListTile(
            leading: Icon(Icons.help_outline_outlined) ,
            title: Text("Help Center"),
            onTap: ()=> null,),
          ListTile(
            leading: Icon(Icons.logout) ,
            title: Text("Logout"),
            onTap: ()=> null,),
        ],
      ),
    );
  }
}
