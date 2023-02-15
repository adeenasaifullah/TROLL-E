import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:troll_e/views/shopping_history/shopping_history.dart';
import 'package:flutter_gif/flutter_gif.dart';

class Checkout extends StatefulWidget {

  Reciept reciept= Reciept(date: DateTime(1989, 11, 9), total: 21000,
      products: [
        Product(name: "Ponam Sugar 5 Kg", price: 2500, discount: 0, quantity: 2, itemTotal: 5000),
        Product(name: "Ponam Sugar 2 Kg", price: 1000, discount: 0, quantity: 3, itemTotal: 2000),
        Product(name: "Ponam Sugar 5 Kg", price: 2500, discount: 0, quantity: 2, itemTotal: 5000),
        Product(name: "Ponam Sugar 2 Kg", price: 1000, discount: 0, quantity: 3, itemTotal: 2000),
        Product(name: "Ponam Sugar 5 Kg", price: 2500, discount: 0, quantity: 2, itemTotal: 5000),
        Product(name: "Ponam Sugar 2 Kg", price: 1000, discount: 0, quantity: 3, itemTotal: 2000)
      ]);

  Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> with TickerProviderStateMixin {
  late FlutterGifController controller1;
  @override
  void initState() {
    controller1 = FlutterGifController(vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller1.repeat(
        min: 0,
        max: 60,
        period: const Duration(seconds: 3),
      );
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text((dateFormat.format(widget.reciept.date)).toString(), style: TextStyle(color: Colors.black,),),

        backgroundColor: const Color(0xFFBAD3D4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text("You have successfully checked out!", style: TextStyle(fontSize: 15),),
          ),
          SizedBox(height: 25),
          // GifImage(
          //   controller: controller1,
          //   image: const AssetImage("Assets/images/checkoutgif.gif"),
          // ),
          //Image.asset("Assets/images/checkoutgif.gif", gaplessPlayback: false),
          SizedBox(height: 150, child: Image.asset("Assets/images/checkout.png"),),
          SizedBox(height: 25),

          Text("Product Description", style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              children: const [
                Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Discount", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
                Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(
                  flex: 2, // <-- SEE HERE
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0) ,
              itemCount: widget.reciept.products.length,
              itemBuilder: (context, index) => Column(
                children: [

                  ListTile(

                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(widget.reciept.products[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Row(
                      children: [
                        Text(widget.reciept.products[index].quantity.toString()),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(widget.reciept.products[index].price.toString()),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(widget.reciept.products[index].discount.toString()),
                        Spacer(
                          flex: 2, // <-- SEE HERE
                        ),
                        Text(widget.reciept.products[index].itemTotal.toString()),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.7, indent: 15, endIndent: 15),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}


Reciept example = Reciept(date: DateTime(1989, 11, 9), total: 21000,
    products: [
      Product(name: "Ponam Sugar 5 Kg", price: 2500, discount: 0, quantity: 2, itemTotal: 5000),
      Product(name: "Ponam Sugar 2 Kg", price: 1000, discount: 0, quantity: 3, itemTotal: 2000),
      Product(name: "Ponam Sugar 5 Kg", price: 2500, discount: 0, quantity: 2, itemTotal: 5000),
      Product(name: "Ponam Sugar 2 Kg", price: 1000, discount: 0, quantity: 3, itemTotal: 2000),
      Product(name: "Ponam Sugar 5 Kg", price: 2500, discount: 0, quantity: 2, itemTotal: 5000),
      Product(name: "Ponam Sugar 2 Kg", price: 1000, discount: 0, quantity: 3, itemTotal: 2000)
    ]);