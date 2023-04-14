import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../controller/item_provider.dart';
import '../../controller/profile_provider.dart';
import '../../models/Item_model.dart';
import '../../utility.dart';

class CartInputWrapper extends StatefulWidget {
  const CartInputWrapper({
    Key? key,
  }) : super(key: key);

  @override
  _CartInputWrapperState createState() => _CartInputWrapperState();
}

class _CartInputWrapperState extends State<CartInputWrapper> {
  String _result = "";
  final TextEditingController weightController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  // List<ItemModel>? items = [];

  _scanBR() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
          "#000000", "Cancel", true, ScanMode.BARCODE)
          .then((value) => setState(() => _result = value));
      // setState(() {
      //   _result = value;
      // });
    } catch (ex) {
      setState(() {
        _result = "Unknown Error $ex";
      });
    }
  }

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false)
        .getUserProfile(context: context);
    callGetReceipt();
    // TODO: implement initState
    super.initState();
    print(
        "TOTAL ITEMSS IN A LISTTTT  ${Provider
            .of<ItemProvider>(context, listen: false)
            .itemList
            ?.length}");
  }

  void callGetReceipt() async {
    // await Provider.of<ItemProvider>(context, listen: false).getReceipt(
    //     user: Provider.of<ProfileProvider>(context, listen: false).user);
    await context.read<ItemProvider>().getReceipt(user: context
        .read<ProfileProvider>()
        .user);
    print("CALLGETRECEIPT INIT STATE");
    // final profileProvider = Provider.of<ProfileProvider>(context);
    //  final itemProvider = Provider.of<ItemProvider>(context);
    //  items =  itemProvider.getReceipt(user: profileProvider.user) as List<ItemModel>?;
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);
    //itemProvider.getReceipt(user: profileProvider.user);

    return Scaffold(
      body: itemProvider.itemList?.length == 0
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150.h,
          ),
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
                      color: const Color(0xFF779394),
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
                    primary: const Color(0xff262626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    await _scanBR();
                    print("THIS IS THE BARCODE SCANNED :");
                    print(_result);
                    itemProvider.addItemToTemp(
                        user: Provider
                            .of<ProfileProvider>(context,
                            listen: false)
                            .user,
                        barcode: _result,
                        context: context);
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
                      color: const Color(0xFF779394),
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
                        color: const Color(0xFF779394),
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
          : Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: itemProvider.itemList?.length,
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const ListTile(
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
                Column(children: <Widget>[
                  Text("Net Weight",
                      style: GoogleFonts.robotoCondensed(
                          color: const Color(0xFF779394),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 3.h),
                  Container(
                    width: 60,
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: const Color(0xFF779394), width: 1)),
                    alignment: Alignment.center,
                    // child: const Center(
                    child: Text(
                      "5 kg",
                      style: GoogleFonts.robotoCondensed(
                          color: const Color(0xFF779394),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    //),
                  ),
                ]),
                SizedBox(width: 35.w),
                SizedBox(
                  height: 50.h,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(90.0, 50.0),
                      primary: const Color(0xff262626),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () async {
                      await _scanBR();
                      itemProvider.addItemToTemp(
                          user: Provider
                              .of<ProfileProvider>(context,
                              listen: false)
                              .user,
                          barcode: _result,
                          context: context);
                    },
                    icon: (Image.asset('Assets/icons/scanner.png')),
                    label: const Text(''),
                  ),
                ),
                SizedBox(width: 35.w),
                Column(children: <Widget>[
                  Text("Total Cost",
                      style: GoogleFonts.robotoCondensed(
                          color: const Color(0xFF779394),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 3.h),
                  Container(
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: const Color(0xFF779394), width: 1)),
                    alignment: Alignment.center,
                    // child: const Center(
                    child: Text(
                      "PKR 1,250",
                      style: GoogleFonts.robotoCondensed(
                          color: const Color(0xFF779394),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    //),
                  ),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
