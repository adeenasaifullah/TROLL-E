import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/utility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:troll_e/views/menu/menu.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../../controller/item_provider.dart';
import '../../controller/profile_provider.dart';
import '../../controller/shopping_provider.dart';
import '../../models/user_model.dart';
import '../cart/shopping_cart.dart';

class HomeScreen extends StatefulWidget {
  final token;

  const HomeScreen({Key? key, this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String username;
  late bool cartConnected;

  //= false;
  String qrCode = "";

  //late SharedPreferences prefs;
  Future<String> scanQR() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
              "#000000", "Cancel", true, ScanMode.QR)
          .then((value) => setState(() => qrCode = value));
      return qrCode;
      // setState(() {
      //   _result = qrResult;
      // });
    } catch (ex) {
      setState(() {
        qrCode = "Unknown Error $ex";
      });
      return qrCode;
    }
  }

  @override
  void initState() {
    context.read<ProfileProvider>().getUserProfile(context: context);
    //connected();
    //cartConnected = prefs.getBool("result")!;
    //cartConnected = context.read<ShoppingProvider>().result;
    cartConnected = context.read<ProfileProvider>().result;

    // Provider.of<ItemProvider>(context).getReceipt(
    //     user: Provider.of<ProfileProvider>(context).user);
    super.initState();
  }

  // void connected() async {
  //   prefs = await SharedPreferences.getInstance();
  //
  // }

  @override
  Widget build(BuildContext context) {
    final username =
        Provider.of<ProfileProvider>(context).user?.firstName.toCapitalized();
    final shoppingProvider = Provider.of<ShoppingProvider>(context);

    //final itemProvider = Provider.of<ItemProvider>(context);
    //profileProvider.getUserProfile(context: context);
    //final username = Provider.of<ProfileProvider>(context).user?.first_name;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const Menu(),
      appBar:
          // PreferredSize(
          //   preferredSize: Size.fromHeight(80.0),
          //  child:
          AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        //title: Image.asset('Assets/images/TROLL-E-without-tagline.png', fit: BoxFit.cover, height: 150.h,)
      ),
      //   ),
      body: Provider.of<ProfileProvider>(context).isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/images/bg3.jpeg'),
                  fit: BoxFit.cover,
                ),
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Colors.black54,
                //     //Color(0xffFFFFFF),
                //   ],
                // )
                //color: Color(0xff434343)
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: displayHeight(context) * 0.2),

                    //Container(height: 150.h,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: displayHeight(context) * 0.8,
                          width: displayWidth(context),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: displayHeight(context) * 0.07),
                              Roboto_subheading(
                                  textValue: "Welcome, $username ",
                                  size: 18.sp),
                              SizedBox(
                                height: displayHeight(context) * 0.1,
                              ),
                              CircleAvatar(
                                backgroundColor: kPrimaryDarkColor,
                                radius: 105.r,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 100.r,
                                  child: GlowButton(
                                    width: 170.w,
                                    height: 170.h,
                                    onPressed: () async {
                                      // true means its glowing
                                      if (cartConnected == true) {
                                      } else {
                                        String uid = await scanQR();
                                        await shoppingProvider.connect(
                                            context,
                                            uid,
                                            Provider.of<ProfileProvider>(
                                                    context,
                                                    listen: false)
                                                .user);
                                        print("THIS IS THE QR CODE : $qrCode");
                                        print(
                                            "this is shopping provider result");
                                        print(shoppingProvider.result);
                                        // cartConnected = shoppingProvider.result;
                                        setState(() {
                                          cartConnected =
                                              shoppingProvider.result;
                                          //  cartConnected  = true;
                                        });
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(500.r),
                                    color: cartConnected
                                        ? kPrimaryDarkColor
                                        : const Color(0xffDDE7E8),
                                    blurRadius: cartConnected ? 50 : 0,
                                    spreadRadius: cartConnected ? 10 : 0,
                                    child: Image.asset(
                                      'Assets/icons/connect.png',
                                      width: 150.w,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80.h,
                              ),
                              GlowButton(
                                width: 300.w,
                                height: 50.h,
                                borderRadius: BorderRadius.circular(15),
                                color: cartConnected
                                    ? Colors.black54
                                    : const Color(0xffDDE7E8),
                                blurRadius: 0,
                                spreadRadius: 0,
                                onPressed: () {
                                  setState(() {});
                                  cartConnected
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Shoppingcart(),
                                          ),
                                        )
                                      : null;
                                },
                                child: const Text(
                                  "Start Shopping",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              // FloatingActionButton(onPressed: () {
                              //   Navigator.push( context,
                              //   MaterialPageRoute(builder: (context) =>  Shoppingcart()),
                              // );
                              // },
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
