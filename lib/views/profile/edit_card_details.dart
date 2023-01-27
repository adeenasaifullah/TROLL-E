import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:troll_e/utility.dart';
import 'package:troll_e/views/profile/card_details.dart';

class EditCardDetails extends StatefulWidget {
  const EditCardDetails({Key? key}) : super(key: key);

  @override
  State<EditCardDetails> createState() => _EditCardDetailsState();
}

class _EditCardDetailsState extends State<EditCardDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.black),
        title:  Roboto_heading(textValue: 'Edit Card Details', size: 20.sp)
      ),
      body: CardDetails(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),

    );
  }
}
