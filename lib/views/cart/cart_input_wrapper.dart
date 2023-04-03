import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:troll_e/utility.dart';

import '../../controller/item_provider.dart';
import '../../controller/profile_provider.dart';
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
  List<ItemModel>? items=[];

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

  void initState()  {


     callGetReceipt();
    // TODO: implement initState
    super.initState();
  }
  late ProfileProvider profileProvider;

  void callGetReceipt() async {
  profileProvider = Provider.of<ProfileProvider>(context);
  profileProvider.getUserProfile(context: context);
  final itemProvider = Provider.of<ItemProvider>(context);
  items =  itemProvider.getReceipt(user: profileProvider.user) as List<ItemModel>?;

  }
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    profileProvider.getUserProfile(context: context);
    final itemProvider = Provider.of<ItemProvider>(context);
    //itemProvider.getReceipt(user: profileProvider.user);

    return Scaffold(
        body: itemProvider.itemlist?.length==0 ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150.h,),
            Center(
              child: Text(
                "Your Cart is Empty\nScan to add items to the cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: kPrimaryDarkColor,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 240.h), // add some spacing between the widgets
            // Expanded( // add Expanded to take the remaining space
            //   child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Column(
                    children: <Widget>[
                      Text(
                        "Net Weight",
                        style: GoogleFonts.robotoCondensed(
                          color:const  Color(0xFF779394),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: 60,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xFF779394),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "5 kg",
                          style: GoogleFonts.robotoCondensed(
                            color: const Color(0xFF779394),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 35.w),
                  SizedBox(
                    height: 50.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(90.0, 50.0),
                        backgroundColor: const Color(0xff262626),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                        await _scanBR();
                        print("THIS IS THE BARCODE SCANNED :");
                        print(_result);
                        itemProvider.addItemToTemp(user: profileProvider.user, barcode: _result);
                        },
                      icon: (Image.asset('Assets/icons/scanner.png')),
                      label: const Text(''),
                    ),
                  ),
                  SizedBox(width: 35.w),
                  Column(
                    children: <Widget>[
                      Text(
                        "Total Cost",
                        style: GoogleFonts.robotoCondensed(
                          color:const Color(0xFF779394),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: 70,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xFF779394),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "PKR 1,250",
                          style: GoogleFonts.robotoCondensed(
                            color:const Color(0xFF779394),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
           // ),
          ],
        )

        :
        Center(
            child: Column(
              children: <Widget>[

                    Expanded(
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: itemProvider.itemlist?.length,
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
                                title: Text("title"),
                                //Text(itemProvider.itemlist[index]?.name ?? ''),
                                subtitle: Text("subtitle")
                                //Text("\Rs ${(itemProvider.itemlist[index].price).toString()} x${itemProvider.itemlist[index].quantity}")

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
                                  color: const Color(0xFF779394), fontSize: 15.sp, fontWeight: FontWeight.w400)),
                          SizedBox(height: 3.h),
                          Container(
                             width: 60, height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: const Color(0xFF779394), width: 1)
                            ),
                            alignment: Alignment.center,
                            // child: const Center(
                            child: Text("5 kg",
                              style: GoogleFonts.robotoCondensed(
                                  color: const Color(0xFF779394), fontSize: 15.sp, fontWeight: FontWeight.w400),
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
                        label: const Text(''),
                      ),
                    ),
                    SizedBox(width: 35.w),
                    Column(
                        children: <Widget>[
                          Text("Total Cost",
                              style: GoogleFonts.robotoCondensed(
                                  color: const Color(0xFF779394), fontSize: 15.sp, fontWeight: FontWeight.w400)),
                          SizedBox(height: 3.h),
                          Container(
                            width: 70, height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: const Color(0xFF779394), width: 1)
                            ),
                            alignment: Alignment.center,
                            // child: const Center(
                            child: Text("PKR 1,250",
                              style: GoogleFonts.robotoCondensed(
                                  color: const Color(0xFF779394), fontSize: 13.sp, fontWeight: FontWeight.w400),
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