//
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/material.dart';
//
// class ChangePassword {
//   TextEditingController currentpw = TextEditingController();
//   TextEditingController newpw= TextEditingController();
//   TextEditingController confirmpw= TextEditingController();
//   showDialog(BuildContext context) {
//     return AlertDialog(
//       shape: const RoundedRectangleBorder(
//           borderRadius:
//           BorderRadius.all(
//               Radius.circular(8.0))),
//       // title: const Text('Popup example'),
//       content:  Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Current Password',
//
//             ),
//             controller: currentpw,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'This field is required';
//               }
//               return null;
//             },
//             obscureText: true,
//
//           ),SizedBox(height: 10.h),
//
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'New Password',
//             ),
//             controller: newpw,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'This field is required';
//               }
//               return null;
//             },
//             obscureText: true,
//
//           ),SizedBox(height: 10.h),
//
//
//           TextFormField(
//             decoration: const InputDecoration(
//               hintText: 'Confirm Password',
//             ),
//             controller: confirmpw,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'This field is required';
//               }
//               return null;
//             },
//             obscureText: true,
//
//           ),
//           SizedBox(height: 20.h,),
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Save Changes'),
//               style: ElevatedButton.styleFrom(
//                   primary: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12), // <-- Radius
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
//                   textStyle: TextStyle(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.bold))
//           )
//
//
//         ],
//       ),
//
//     );
//   }
//
//
//
// }