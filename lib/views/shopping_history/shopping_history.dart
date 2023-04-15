import 'dart:isolate';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/models/receipt_object_model.dart';
import 'package:troll_e/models/shopping_history.dart';
import 'package:troll_e/models/user_model.dart';
import 'package:troll_e/views/shopping_history/single_history.dart';
import '../../controller/history_provider.dart';
import '../../controller/profile_provider.dart';
import '../../utility.dart';
import '../menu/menu.dart';

class ShoppingHistory extends StatefulWidget {
  const ShoppingHistory({Key? key}) : super(key: key);

  @override
  _ShoppingHistoryState createState() => _ShoppingHistoryState();
}

class _ShoppingHistoryState extends State<ShoppingHistory> {

  // List<Reciept> history = [
  //   Reciept(date: DateTime.now(), total: 21000, products: [
  //     Product(
  //         name: "Ponam Sugar 5 Kg",
  //         price: 2500,
  //         discount: 0,
  //         quantity: 2,
  //         itemTotal: 5000),
  //     Product(
  //         name: "Ponam Sugar 2 Kg",
  //         price: 1000,
  //         discount: 0,
  //         quantity: 3,
  //         itemTotal: 2000),
  //     Product(
  //         name: "Ponam Sugar 5 Kg",
  //         price: 2500,
  //         discount: 0,
  //         quantity: 2,
  //         itemTotal: 5000),
  //     Product(
  //         name: "Ponam Sugar 2 Kg",
  //         price: 1000,
  //         discount: 0,
  //         quantity: 3,
  //         itemTotal: 2000),
  //     Product(
  //         name: "Ponam Sugar 5 Kg",
  //         price: 2500,
  //         discount: 0,
  //         quantity: 2,
  //         itemTotal: 5000),
  //     Product(
  //         name: "Ponam Sugar 2 Kg",
  //         price: 1000,
  //         discount: 0,
  //         quantity: 3,
  //         itemTotal: 2000)
  //   ]),
  //   Reciept(date: DateTime.now(), total: 5000, products: [
  //     Product(
  //         name: "Ponam Sugar 5 Kg",
  //         price: 2500,
  //         discount: 0,
  //         quantity: 2,
  //         itemTotal: 5000),
  //   ])
  // ];

  @override
    void initState()
    {

     //Provider.of<ProfileProvider>(context).getUserProfile(context: context);
     print("PRINTING USERRR ${context.read<ProfileProvider>().user?.firstName}");
      //Provider.of<HistoryProvider>(context, listen: false).getHistoryProvider(user: Provider.of<ProfileProvider>(context, listen: false).user);

      super.initState();
    }


  @override
  Widget build(BuildContext context) {
   final history = Provider.of<ProfileProvider>(context).user?.shoppingHistory;
   return Scaffold(
      drawer:  Menu(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),

        centerTitle: true,
        title: Roboto_heading(textValue: 'Shopping History', size: 20.sp),
        backgroundColor: const Color(0xFFBAD3D4),
      ),
    body:  Provider.of<ProfileProvider>(context).isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : history?.length == 0
        ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 150.h,
        ),
        Center(
          child: Text(
            "You Do Not Have A \n Shopping History Right Now",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              color: kPrimaryDarkColor,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(
          height: 240.h,
        ), // add some spacing between the widgets

      ],
    )
        :
    //     profileProvider.user?.shoppingHistory == null ?
    //     Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //     SizedBox(
    //     height: 150.h,
    //   ),
    //   Center(
    //     child: Text(
    //       "You don't have an previously saved receipts.",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 20.sp,
    //         color: kPrimaryDarkColor,
    //         fontWeight: FontWeight.bold,
    //         fontStyle: FontStyle.italic,
    //       ),
    //     ),
    //   ),
    //   ]
    // ):

      Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              itemCount: history?.length,
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                          (history?[index].date).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Text("Total: Rs ${history?[index].netTotal}"),
                    trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 15.0),
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         SingleHistory(reciept: history![index]),
                          //   ),
                          // );
                        }),
                  ),
                  const Divider(thickness: 1.7, indent: 15, endIndent: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Reciept {
  final DateTime date;
  double total;
  List<Product> products;

  Reciept({required this.date, required this.total, required this.products});
}

DateFormat dateFormat = DateFormat("dd MMMM yyyy");

class Product {
  String name;
  int quantity;
  double price;
  double discount;
  double itemTotal;

  Product(
      {required this.name,
      required this.quantity,
      this.discount = 0,
      required this.price,
      required this.itemTotal});
}
