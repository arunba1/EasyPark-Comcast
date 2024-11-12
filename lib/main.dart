import 'package:car_parking_system/Homescreen.dart';
import 'package:car_parking_system/Loginscreen.dart';
import 'package:car_parking_system/Parkingscreen.dart';
import 'package:car_parking_system/Parkingtrial.dart';
import 'package:car_parking_system/Registerscreen.dart';
import 'package:car_parking_system/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SeatProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bus Seat Booking App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Splashscreen(),
        // home: Homescreen(
        //   email: "arun@comcast.com",
        // ),
      ),
    );
  }
}
