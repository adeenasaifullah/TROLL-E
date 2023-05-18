import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:troll_e/utility.dart';
import 'package:troll_e/views/homescreen/homescreen.dart';

import 'demo_screen_1.dart';
import 'demo_screen_2.dart';
import 'demo_screen_3.dart';
import 'demo_screen_4.dart';

class DemoScreen extends StatefulWidget {
  // final token;
  const DemoScreen({Key? key}) : super(key: key);

  @override

  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with SingleTickerProviderStateMixin {

  int _currentScreenIndex = 0;


  final List<Widget> _screens = [
    DemoScreenOne(),
    DemoScreenTwo(),
    DemoScreenThree(),
    DemoScreenFour(),

  ];

  final List<String> steps = [
    "Step 1",
    "Step 2",
    "Step 3",
    "Step 4"
  ];



  late AnimationController _animationController;
  late Animation<double> _animation;

  void _handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity! < 0 && _currentScreenIndex > 0) {
      // Swipe right to go to previous screen
      setState(() {
        _currentScreenIndex--;
      });
    } else if (details.primaryVelocity! > 0 &&
        _currentScreenIndex < _screens.length - 1) {
      // Swipe left to go to next screen
      setState(() {
        _currentScreenIndex++;
      });
    }
    _animationController.animateTo(_currentScreenIndex / (_screens.length - 1));
  }

  void _handleSkip() {
    // Navigate to home screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) =>  HomeScreen(token: widget.token)),
    // );
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

  }

  @override
  Widget build(BuildContext context) {
    final List<double> leftDistance = [
      70.w,
      66.w,
      66.w,
      160.w
    ];
    final List<double> topDistance = [
      40.h,
      140.h,
      10.h,
      140.h


    ];
    return Scaffold(
      body: Stack(
        children: [
          // The demo screen widget
          GestureDetector(
            onHorizontalDragEnd: _handleSwipe,
            child: _screens[_currentScreenIndex],
          ),
          // The hand icon widget
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            left: leftDistance[_currentScreenIndex] + MediaQuery.of(context).size.width/4,
            top: topDistance[_currentScreenIndex] + MediaQuery.of(context).size.height/4,
            child: Column(
              children: [
                Icon(Icons.touch_app, size: 50,),
              ],
            ),

          ),
          // The dotted progress bar widget
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_screens.length, (index) {
                    return Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentScreenIndex == index
                            ? Color(0xFF57CBC1)
                            : Colors.grey,
                      ),
                      margin: EdgeInsets.only(
                          right: index < _screens.length - 1 ? 10 : 0),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // The skip button widget
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: _handleSkip,
              child: Text('Skip for now >'),
            ),
          ),
          Positioned(
            top: 30,
            left:28,
            child: Roboto_heading(textValue: steps[_currentScreenIndex],size: 35,),
          ),
        ],
      ),
    );
  }
}

