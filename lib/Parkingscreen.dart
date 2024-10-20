// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class Parkingscreen extends StatefulWidget {
// //   const Parkingscreen({super.key});

// //   @override
// //   State<Parkingscreen> createState() => _ParkingscreenState();
// // }

// // class _ParkingscreenState extends State<Parkingscreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = Provider.of<SeatProvider>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Parking Screen'),
// //       ),
// //       body: Column(
// //         children: [
// //           SizedBox(height: 30),
// //           Expanded(
// //             child: GridView.builder(
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 5,
// //               ),
// //               itemCount: provider.seats.length,
// //               itemBuilder: (context, index) {
// //                 final seat = provider.seats[index];
// //                 final isBooked = provider.isSeatBooked(seat);

// //                 return Stack(
// //                   children: [
// //                     Image.asset(
// //                       'assets/seat.png',
// //                       color: isBooked ? Colors.red : Colors.grey,
// //                     ),
// //                     SizedBox(
// //                       height: 50,
// //                       child: Center(
// //                         child: Text(
// //                           seat,
// //                           style: TextStyle(
// //                             color: isBooked ? Colors.white : Colors.black,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class SeatProvider with ChangeNotifier {
// //   List<String> seats = [
// //     '1A',
// //     '1B',
// //     '1C',
// //     '1D',
// //     '1E',
// //     '2A',
// //     '2B',
// //     '2C',
// //     '2D',
// //     '2E',
// //     '3A',
// //     '3B',
// //     '3C',
// //     '3D',
// //     '3E',
// //     '4A',
// //     '4B',
// //     '4C',
// //     '4D',
// //     '4E',
// //     '5A',
// //     '5B',
// //     '5C',
// //     '5D',
// //     '5E',
// //     '6A',
// //     '6B',
// //     '6C',
// //     '6D',
// //     '6E'
// //   ];

// //   // List<String> bookedSeats = [];
// //   Map<String, DateTime> bookedSeats = {};

// //   SeatProvider() {
// //     _loadBookedSeats();
// //   }

// //   // void bookSeat(String seat) {
// //   //   bookedSeats.add(seat);
// //   //   notifyListeners();
// //   // }
// //   // Book a seat and store the timestamp
// //   void bookSeat(String seat) async {
// //     DateTime now = DateTime.now();
// //     bookedSeats[seat] = now;
// //     notifyListeners();
// //     await _saveBookedSeats(); // Save the booking information locally
// //   }

// //   // Check if the seat is booked within the last 12 hours
// //   bool isSeatBooked(String seat) {
// //     if (bookedSeats.containsKey(seat)) {
// //       DateTime bookedTime = bookedSeats[seat]!;
// //       if (DateTime.now().difference(bookedTime).inHours < 12) {
// //         return true; // Seat is still booked
// //       } else {
// //         bookedSeats.remove(seat); // Remove expired booking
// //         _saveBookedSeats();
// //       }
// //     }
// //     return false;
// //   }

// //   // Load booked seats from SharedPreferences
// //   Future<void> _loadBookedSeats() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? bookedSeatsString = prefs.getString('bookedSeats');
// //     if (bookedSeatsString != null) {
// //       Map<String, String> storedSeats =
// //           Map<String, String>.from(jsonDecode(bookedSeatsString));
// //       bookedSeats =
// //           storedSeats.map((seat, time) => MapEntry(seat, DateTime.parse(time)));
// //       notifyListeners();
// //     }
// //   }

// //   // Save booked seats to SharedPreferences
// //   Future<void> _saveBookedSeats() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     Map<String, String> stringSeats =
// //         bookedSeats.map((seat, time) => MapEntry(seat, time.toIso8601String()));
// //     await prefs.setString('bookedSeats', jsonEncode(stringSeats));
// //   }
// // }

// // // String apiUrl = "http://192.168.1.7:3000/book-seat";

// // // Future<void> sendSeatToBackend(String seat) async {
// // //   final response = await http.post(
// // //     Uri.parse(apiUrl),
// // //     headers: {
// // //       "Content-Type": "application/json",
// // //     },
// // //     body: jsonEncode({
// // //       "seatNumber": seat,
// // //     }),
// // //   );

// // //   if (response.statusCode == 200) {
// // //     print("Seat $seat booked successfully");
// // //   } else {
// // //     print("Failed to book seat $seat");
// // //   }
// // // }

// // String apiUrl = "http://192.168.1.7:3000/book-seat";

// // Future<void> sendSeatToBackend(String seat) async {
// //   final response = await http.post(
// //     Uri.parse(apiUrl),
// //     headers: {
// //       "Content-Type": "application/json",
// //     },
// //     body: jsonEncode({
// //       "seatNumber": seat,
// //     }),
// //   );

// //   if (response.statusCode == 200) {
// //     print("Seat $seat booked successfully");
// //   } else {
// //     print("Failed to book seat $seat");
// //   }
// // }

// // import 'dart:js';

// // import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// // class Parkingscreen extends StatefulWidget {
// //   const Parkingscreen({super.key});

// //   @override
// //   State<Parkingscreen> createState() => _ParkingscreenState();
// // }

// class Parkingscreen extends StatelessWidget {
//   final String email;

//   const Parkingscreen({Key? key, required this.email}) : super(key: key);

// //   @override
// //   State<Parkingscreen> createState() => _ParkingscreenState();
// // }

// // class _ParkingscreenState extends State<Parkingscreen> {

//   //  final String email;

//   // const Parkingscreen({Key? key, required this.email}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SeatProvider>(context);
//     return Scaffold(
//       backgroundColor: Colors.white24,
//       appBar: AppBar(
//         title: Text('Book your slot $email'),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 30,
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 5,
//               ),
//               itemCount: provider.seats.length,
//               itemBuilder: (context, index) {
//                 final seat = provider.seats[index];
//                 final isBooked = provider.isSeatBooked(seat);
//                 return GestureDetector(
//                   onTap: () async {
//                     if (!isBooked) {
//                       await sendSeatToBackend(context, seat, email);
//                       provider.bookSeat(seat); // Mark the seat as booked
//                     }
//                   },
//                   child: Stack(
//                     children: [
//                       Image.asset(
//                         'assets/seat.png',
//                         color: isBooked ? Colors.red : Colors.grey,
//                       ),
//                       Text(
//                         seat,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SeatProvider with ChangeNotifier {
//   List<String> seats = [
//     '1A',
//     '1B',
//     '1C',
//     '1D',
//     '1E',
//     '2A',
//     '2B',
//     '2C',
//     '2D',
//     '2E',
//     '3A',
//     '3B',
//     '3C',
//     '3D',
//     '3E',
//     '4A',
//     '4B',
//     '4C',
//     '4D',
//     '4E',
//     '5A',
//     '5B',
//     '5C',
//     '5D',
//     '5E',
//     '6A',
//     '6B',
//     '6C',
//     '6D',
//     '6E'
//   ];

//   Map<String, DateTime> bookedSeats = {};

//   SeatProvider() {
//     _loadBookedSeats();
//   }

//   void bookSeat(String seat) async {
//     DateTime now = DateTime.now();
//     bookedSeats[seat] = now;
//     notifyListeners();
//     await _saveBookedSeats();
//   }

//   bool isSeatBooked(String seat) {
//     if (bookedSeats.containsKey(seat)) {
//       DateTime bookedTime = bookedSeats[seat]!;
//       if (DateTime.now().difference(bookedTime).inHours < 12) {
//         return true;
//       } else {
//         bookedSeats.remove(seat);
//         _saveBookedSeats();
//       }
//     }
//     return false;
//   }

//   Future<void> _loadBookedSeats() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? bookedSeatsString = prefs.getString('bookedSeats');
//     if (bookedSeatsString != null) {
//       Map<String, String> storedSeats =
//           Map<String, String>.from(jsonDecode(bookedSeatsString));
//       bookedSeats =
//           storedSeats.map((seat, time) => MapEntry(seat, DateTime.parse(time)));
//       notifyListeners();
//     }
//   }

//   Future<void> _saveBookedSeats() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Map<String, String> stringSeats =
//         bookedSeats.map((seat, time) => MapEntry(seat, time.toIso8601String()));
//     await prefs.setString('bookedSeats', jsonEncode(stringSeats));
//   }
// }

// String apiUrl =
//     "https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/book_slot";

// Future<void> sendSeatToBackend(
//     BuildContext context, String seat, String email) async {
//   final response = await http.post(
//     Uri.parse(apiUrl),
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode({"email": email, "slot": seat}),
//   );
//   if (response.statusCode == 200) {
//     print(response.body);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(response.body),
//       backgroundColor: Colors.green,
//       duration: Duration(seconds: 3),
//     ));
//   } else {
//     final responsedata = jsonDecode(response.body);
//     final message = responsedata['message'];
//     print("Failed to book seat $seat");
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.red,
//       duration: Duration(seconds: 3),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Parkingscreen extends StatelessWidget {
  final String email;

  const Parkingscreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SeatProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white24,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // shadowColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: Text(
          'Book your slot $email',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Parkingscreen(email: email),
                          ));
                    },
                    child: Text('1st Floor')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(onPressed: () {}, child: Text('2nd Floor')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(onPressed: () {}, child: Text('3rd Floor')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(onPressed: () {}, child: Text('4th Floor')),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
              ),
              itemCount: provider.seats.length,
              itemBuilder: (context, index) {
                final seat = provider.seats[index];
                final isBooked = provider.isSeatBooked(seat);
                final isSelected = provider.selectedSeat == seat;
                return GestureDetector(
                    onTap: () {
                      if (!isBooked) {
                        provider.selectSeat(seat); // Select the seat
                      }
                    },
                    // child: Stack(
                    //   children: [
                    //     Image.asset(
                    //       'assets/seat.png',
                    //       color: isBooked
                    //           ? Colors.red
                    //           : isSelected
                    //               ? Colors.purple
                    //               : Colors.green,
                    //     ),
                    //     Text(
                    //       seat,
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    child: Container(
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: isBooked
                            ? Colors.white12
                            : isSelected
                                ? Colors.purple
                                : Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: isBooked
                            // ? Icon(Icons.directions_car, color: Colors.black)
                            ? Image.asset('assets/slot3.jpg')
                            : Text(
                                seat,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ));
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: ElevatedButton(
              onPressed: provider.selectedSeat != null
                  ? () async {
                      await sendSeatToBackend(
                          context, provider.selectedSeat!, email);
                      provider.bookSeat(
                          provider.selectedSeat!); // Mark the seat as booked
                      provider.clearSelectedSeat(); // Clear the selection
                    }
                  : null,
              child: Text('Book'),
            ),
          ),
        ],
      ),
    );
  }
}

class SeatProvider with ChangeNotifier {
  List<String> seats = [
    '1A',
    '1B',
    '1C',
    '1D',
    '1E',
    '2A',
    '2B',
    '2C',
    '2D',
    '2E',
    '3A',
    '3B',
    '3C',
    '3D',
    '3E',
    '4A',
    '4B',
    '4C',
    '4D',
    '4E',
    '5A',
    '5B',
    '5C',
    '5D',
    '5E',
    '6A',
    '6B',
    '6C',
    '6D',
    '6E'
  ];

  Map<String, DateTime> bookedSeats = {};
  String? selectedSeat;

  SeatProvider() {
    _loadBookedSeats();
  }

  void bookSeat(String seat) async {
    DateTime now = DateTime.now();
    bookedSeats[seat] = now;
    notifyListeners();
    await _saveBookedSeats();
  }

  void selectSeat(String seat) {
    selectedSeat = seat;
    notifyListeners();
  }

  void clearSelectedSeat() {
    selectedSeat = null;
    notifyListeners();
  }

  bool isSeatBooked(String seat) {
    if (bookedSeats.containsKey(seat)) {
      DateTime bookedTime = bookedSeats[seat]!;
      if (DateTime.now().difference(bookedTime).inHours < 12) {
        return true;
      } else {
        bookedSeats.remove(seat);
        _saveBookedSeats();
      }
    }
    return false;
  }

  Future<void> _loadBookedSeats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bookedSeatsString = prefs.getString('bookedSeats');
    if (bookedSeatsString != null) {
      Map<String, String> storedSeats =
          Map<String, String>.from(jsonDecode(bookedSeatsString));
      bookedSeats =
          storedSeats.map((seat, time) => MapEntry(seat, DateTime.parse(time)));
      notifyListeners();
    }
  }

  Future<void> _saveBookedSeats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> stringSeats =
        bookedSeats.map((seat, time) => MapEntry(seat, time.toIso8601String()));
    await prefs.setString('bookedSeats', jsonEncode(stringSeats));
  }
}

String apiUrl =
    "https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/book_slot";

Future<void> sendSeatToBackend(
    BuildContext context, String seat, String email) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "slot": seat}),
  );
  if (response.statusCode == 200) {
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.body),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
  } else {
    final responsedata = jsonDecode(response.body);
    final message = responsedata['message'];
    print("Failed to book seat $seat");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
}
