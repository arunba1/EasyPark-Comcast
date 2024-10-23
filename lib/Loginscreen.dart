import 'dart:convert';
import 'dart:ui';
import 'package:car_parking_system/Homescreen.dart';
import 'package:car_parking_system/Parkingscreen.dart';
import 'package:car_parking_system/Registerscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _ispasswordtype = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0,0,139,0.87),
      // backgroundColor: ,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.15, 20, 0),
        child: Column(
              children: [
                SizedBox(height: 0,),
        //         TextField(
        //           controller: emailcontroller,
        //           cursorColor: Colors.white,
        //           style: TextStyle(color: Colors.white.withOpacity(0.9)),
        //     decoration: InputDecoration(prefixIcon: Icon(Icons.person_outline,color:Colors.white70),
        // labelStyle: TextStyle(color: Colors.white.withOpacity(1)),
        // labelText: 'Enter Your Email',
        // filled: true,
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        // fillColor: Colors.white.withOpacity(0.3),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(width: 0,style: BorderStyle.none)),
        //     )
        //           ),
                
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         TextField(
        //           controller: passwordcontroller,
        //           obscureText: _ispasswordtype,
        //           cursorColor: Colors.white,
        //            style: TextStyle(color: Colors.white.withOpacity(0.9)),
        //     decoration: InputDecoration(prefixIcon: Icon(Icons.person_outline,color:Colors.white70),
        // labelStyle: TextStyle(color: Colors.white.withOpacity(1)),
        // labelText: 'Enter Your Password',
        // filled: true,
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        // fillColor: Colors.white.withOpacity(0.3),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(width: 0,style: BorderStyle.none)),
        //     )
        //         ),
            
        //         const SizedBox(
        //           height: 10,
        //         ),
        //         // ElevatedButton(onPressed: postdata, child: const Text('Submit')),
        //         Container(
        //           width: MediaQuery.of(context).size.width,
        //           height: 55,
        //           margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        //           decoration:
        //               BoxDecoration(borderRadius: BorderRadius.circular(90)),
        //           child: ElevatedButton.icon(
        //             onPressed: () => logindatafunction(),
        //             icon: Icon(
        //               Icons.car_rental_outlined,
        //               size: 32,
        //             ),
        //             label: Text("Login",
        //                 style: const TextStyle(
        //                     color: Colors.black,
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 20)),
        //             style: ButtonStyle(
        //                 backgroundColor:
        //                     MaterialStateProperty.resolveWith((states) {
        //                   if (states.contains(MaterialState.pressed)) {
        //                     return Colors.black26;
        //                   }
        //                   return Colors.white;
        //                 }),
        //                 shape:
        //                     MaterialStateProperty.all<RoundedRectangleBorder>(
        //                         RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(30)))),
        //           ),
        //         ),
        //         Row(
        //           // crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             const Text(
        //               "Don't have an account?",
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.normal,
        //                   fontSize: 14),
        //             ),
        //             GestureDetector(
        //               onTap: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => Registerscreen()));
        //               },
        //               child: Text(
        //                 "SignUp",
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 14),
        //               ),
        //             )
        //           ],
        //         ),
                SizedBox(height: 0,),
                Container(
            child: LottieBuilder.asset('assets/Animation-3.json'),
          ),
          TextField(
                  controller: emailcontroller,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
            decoration: InputDecoration(prefixIcon: Icon(Icons.person_outline,color:Colors.white70),
        labelStyle: TextStyle(color: Colors.white.withOpacity(1)),
        labelText: 'Enter Your Email',
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(width: 0,style: BorderStyle.none)),
            )
                  ),
                
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passwordcontroller,
                  obscureText: _ispasswordtype,
                  cursorColor: Colors.white,
                   style: TextStyle(color: Colors.white.withOpacity(0.9)),
            decoration: InputDecoration(prefixIcon: Icon(Icons.person_outline,color:Colors.white70),
        labelStyle: TextStyle(color: Colors.white.withOpacity(1)),
        labelText: 'Enter Your Password',
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(width: 0,style: BorderStyle.none)),
            )
                ),
            
                const SizedBox(
                  height: 10,
                ),
                // ElevatedButton(onPressed: postdata, child: const Text('Submit')),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton.icon(
                    onPressed: () => logindatafunction(),
                    icon: Icon(
                      Icons.car_rental_outlined,
                      size: 32,
                    ),
                    label: Text("Login",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.black26;
                          }
                          return Colors.white;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                  ),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registerscreen()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    )
                  ],
                ),
              ],
            ),
      ))
      
      );
  }

  void logindatafunction() {
    Map<String, String> credentials = {
      "email": emailcontroller.text,
      "password": passwordcontroller.text
    };
    // print(credentials);

    _sendcred(credentials, emailcontroller.text, passwordcontroller.text);
  }

  String apiurl =
      "https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/login";

  Future<void> _sendcred(
      Map<String, dynamic> usercredentials, String a, String b) async {
    print(usercredentials);
    final response = await http.post(Uri.parse(apiurl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": a, "password": b}));
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      // final responsedata = jsonDecode(response.body);
      // final message = responsedata['message'];
      // print(message);
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ));

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homescreen(email: usercredentials['email']),
        ),
      );
    }
  }
}
