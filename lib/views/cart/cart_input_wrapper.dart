import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/Item_model.dart';

class CartInputWrapper extends StatefulWidget {


  const CartInputWrapper({Key? key, })
      : super(key: key);

  @override
  _CartInputWrapperState createState() => _CartInputWrapperState();
}

class _CartInputWrapperState extends State<CartInputWrapper> {
  String _result = "";
  final TextEditingController weightController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  _scanBR() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
          "#000000",
          "Cancel",
          true,
          ScanMode.BARCODE).then((value)=>setState(()=> _result=value));
      // setState(() {
      //   _result = value;
      // });
    }
    catch (ex) {
      setState(() {
        _result = "Unknown Error $ex";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
        return Center(
            child: Column(
              children: <Widget>[
                Items.isEmpty?
                Text(
                  "Scan to add items to the cart",
                  style: new TextStyle(fontSize: 20.sp,),
                ):
                    Expanded(
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: Items.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,

                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: ListTile(
                                leading: FlutterLogo(size: 72.0),
                                title: Text(Items[index].name),
                                subtitle: Text("\Rs ${(Items[index].price).toString()} x${Items[index].quantity}")

                                ),

                      ),
                            ),
                          )),


                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                        children: <Widget>[
                          Text("Net Weight",
                              style: GoogleFonts.robotoCondensed(
                                  color: Color(0xFF779394), fontSize: 15.sp, fontWeight: FontWeight.w400)),
                          SizedBox(height: 3.h),
                          Container(
                             width: 60, height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xFF779394), width: 1)
                            ),
                            alignment: Alignment.center,
                            // child: const Center(
                            child: Text("5 kg",
                              style: GoogleFonts.robotoCondensed(
                                  color: Color(0xFF779394), fontSize: 15.sp, fontWeight: FontWeight.w400),
                            ),
                            //),
                          ),
                        ]
                    ),
                    SizedBox(width: 35.w),
                    SizedBox(
                      height: 50.h,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(90.0, 50.0),
                          backgroundColor: Color(0xff262626),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () { _scanBR(); },
                        icon: (Image.asset('Assets/icons/scanner.png')),
                        label: Text(''),
                      ),
                    ),
                    SizedBox(width: 35.w),
                    Column(
                        children: <Widget>[
                          Text("Total Cost",
                              style: GoogleFonts.robotoCondensed(
                                  color: Color(0xFF779394), fontSize: 15.sp, fontWeight: FontWeight.w400)),
                          SizedBox(height: 3.h),
                          Container(
                            width: 70, height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xFF779394), width: 1)
                            ),
                            alignment: Alignment.center,
                            // child: const Center(
                            child: Text("PKR 1,250",
                              style: GoogleFonts.robotoCondensed(
                                  color: Color(0xFF779394), fontSize: 13.sp, fontWeight: FontWeight.w400),
                            ),
                            //),
                          ),
                        ]
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                )

              ],
            )
        );
  }
}


List <ItemModel> Items = [
  ItemModel(name: "Sugar", description: "Sweet", quantity: "2", SKU: "SKU", barcode: "barcode", Weight: 5, price: 200, discount: 10),
  ItemModel(name: "Salt", description: "Salty", quantity: "2", SKU: "SKU", barcode: "barcode", Weight: 5, price: 200, discount: 10),
  ItemModel(name: "Spice", description: "Spicy", quantity: "2", SKU: "SKU", barcode: "barcode", Weight: 5, price: 200, discount: 10),
  ItemModel(name: "Butter", description: "Buttery", quantity: "2", SKU: "SKU", barcode: "barcode", Weight: 5, price: 200, discount: 10),
  ItemModel(name: "Sugar", description: "Sweet", quantity: "2", SKU: "SKU", barcode: "barcode", Weight: 5, price: 200, discount: 10),
  ItemModel(name: "Salt", description: "Salty", quantity: "2", SKU: "SKU", barcode: "barcode", Weight: 5, price: 200, discount: 10),
  ItemModel(name: "Spice", description: "Spicy", quantity: "2", SKU: "SKU", barcode: "barcode", Weight: 5, price: 200, discount: 10),
  ItemModel(name: "Butter", description: "Buttery", quantity: "2", SKU: "SKU", barcode: "barcode", Weight: 5, price: 200, discount: 10),

];