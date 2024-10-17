import 'dart:ui';

import 'package:car_parking_system/Parkingscreen.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  final String email;

  const Homescreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select any option"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/cp1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 8.5,
                  sigmaY:
                      8.5), // Adjust sigmaX and sigmaY for the desired blur intensity
              child: Container(
                color: Colors.grey.withOpacity(
                    0.3), // You can adjust the color and opacity here
              ),
            ),
          ),
          Positioned(
            top: 240, // adjust the top position of the buttons
            left: 16, // adjust the left position of the buttons
            right: 16, // adjust the right position of the buttons
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
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
                  height: 50,
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
        ],
      ),
    );
  }
}
