import 'dart:ui';

import 'package:car_parking_system/Parkingscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Homescreen extends StatelessWidget {
  final String email;

  const Homescreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0,0,139,0.87),
      // backgroundColor:Colors.orange,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        
        title: Text("Select any option",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
      ),
      body: 
          SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
                SizedBox(height: 20,),
                Container(child: LottieBuilder.asset('assets/Animation-8.json'),),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(50)),
                  ),
                  child: Center(
                      child: Text(
                    "Welcome $email",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Parkingscreen(email: email),
                        ),
                      );
                    },
                    child: Text("Book Your Slot",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue;
                          }
                          return Colors.green;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Parkingscreen(email: email),
                      //   ),
                      // );
                    },
                    child: Text("View Your Slot",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue;
                          }
                          return Colors.green;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                  ),
                ),
              ],
            ),
          ),
        
      );
  }
}
