import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        title: Text("My Shopping Cart", style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.5,
        )

        ),
      ),
      body: CartInputWrapper()
       );
   }
  }