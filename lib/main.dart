import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:troll_e/controller/history_provider.dart';
import 'package:troll_e/controller/item_provider.dart';
import 'package:troll_e/controller/shopping_provider.dart';
import 'package:troll_e/controller/user_provider.dart';
import 'package:troll_e/controller/profile_provider.dart';
import 'package:troll_e/views/Login_Signup/Signup.dart';
import 'package:troll_e/views/app_demo/complete_demo.dart';
import 'package:troll_e/views/app_demo/demo_screen_1.dart';
import 'package:troll_e/views/cart/checkout.dart';
import 'package:troll_e/views/forgot_password/change_password.dart';
import 'package:troll_e/views/forgot_password/forgot_password.dart';
import 'package:troll_e/views/google_auth/google_auth_success_screen.dart';
import 'package:troll_e/views/homescreen/homescreen.dart';
import 'package:troll_e/views/login_signup/login.dart';
import 'package:troll_e/views/login_signup/login_input_wrapper.dart';
import 'package:troll_e/views/login_signup/profile_image.dart';
import 'package:troll_e/views/otp/otp.dart';
import 'package:troll_e/views/profile/user_edit_profile.dart';
import 'package:troll_e/views/help_center/help_center.dart';
import 'package:troll_e/views/splash/splash_screen.dart';
import 'package:troll_e/views/cart/shopping_cart.dart';
import 'package:troll_e/views/shopping_history/shopping_history.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingProvider()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: MyApp(
        token: prefs.getString('accesstoken'),
      ),
    ),
  );
}

// only commenting to push
//token: context.read<UserProvider>().prefs.getString('accesstoken')
class MyApp extends StatelessWidget {
  final token;

  const MyApp({@required this.token, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: (token != null && JwtDecoder.isExpired(token) == false)
                  ? HomeScreen(token: token)
                  : const Login()
              // const SplashScreen()
              //(prefs.getString('accesstoken') != null && JwtDecoder.isExpired(token) == false )?HomeScreen(token: token):SplashScreen()
              //const MyHomePage(title: 'Flutter Demo Home Page'),
              );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Signup(),
                  ),
                );
              },
              child: const Text("Sign up Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: const Text("Edit Profile Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTP(),
                  ),
                );
              },
              child: const Text("OTP"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPassword(),
                  ),
                );
              },
              child: const Text("Forgot Password"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text("HomeScreen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Helpcenter(),
                  ),
                );
              },
              child: const Text("Help Center"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
              child: const Text("Splash screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Shoppingcart()),
                );
              },
              child: const Text("Shop"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShoppingHistory()),
                );
              },
              child: const Text("Shopping History"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Checkout()),
                );
              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
