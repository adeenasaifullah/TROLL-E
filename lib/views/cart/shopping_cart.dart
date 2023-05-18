import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:troll_e/utility.dart';
import 'package:troll_e/views/cart/cart_input_wrapper.dart';

class Shoppingcart extends StatefulWidget {


  const Shoppingcart({Key? key, })
      : super(key: key);

  @override
  _ShoppingcartState createState() => _ShoppingcartState();
}

class _ShoppingcartState extends State<Shoppingcart> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBAD3D4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 16,),
          onPressed: () => Navigator.of(context).pop(),
        ),

        centerTitle: true,
        title: Roboto_heading(textValue: "My Shopping Cart", size: 20.sp,

        ),
      ),
      body: CartInputWrapper()
       );
   }
  }