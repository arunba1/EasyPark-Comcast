// import 'dart:js';

import 'package:car_parking_system/Loginscreen.dart';
import 'package:car_parking_system/Strings.dart';
import 'package:car_parking_system/Styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  changeScreen() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => Loginscreen()),
      );
    });
  }

  @override
  void initState() {
    changeScreen();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(230, 46, 4, 1),
      backgroundColor: Colors.purple,
      body: Column(
        children: [
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Image.asset(
          //     'assets/sp1.png',
          //     width: 310,
          //   ),
          // ),
          // SizedBox(
          //   height: 30,
          // ),
          // Image.asset(icAppLogo)
          //     .box
          //     .white
          //     .size(130, 130)
          //     .padding(const EdgeInsets.all(8))
          //     .rounded
          //     .make(),
          SizedBox(
            height: 200,
          ),
          Container(
            child: LottieBuilder.asset('assets/Animation - 1729410357268.json'),
          ),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          const Spacer(),
          credits.text.white.fontFamily(semibold).make(),
          30.heightBox,
        ],
      ),
    );
  }
}
