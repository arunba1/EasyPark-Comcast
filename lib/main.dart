// import 'package:car_parking_system/Parkingscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => SeatProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Bus Seat Booking App',
//         theme: ThemeData(
//           primarySwatch: Colors.red,
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SeatProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.white24,
//       appBar: AppBar(
//         title: Text('Car Parking Booking'),
//       ),
//       body: Column(
//         children: [
//           // Padding(padding: EdgeInsets.only(left: 30)),
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
//                       await sendSeatToBackend(seat);
//                       provider.bookSeat(seat); // Mark the seat as booked
//                     }
//                   },
//                   child: Stack(
//                     children: [
//                       Image.asset(
//                         'assets/seat.png',
//                         color: isBooked ? Colors.red : Colors.grey,
//                       ),
//                       // Center(
//                       // child:
//                       SizedBox(
//                         height: 50,
//                         child: Text(
//                           seat,
//                           style: TextStyle(
//                             color: isBooked
//                                 ? Colors.white
//                                 : Colors
//                                     .white, // Show red if booked within 12 hours
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       // ),
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

//   // List<String> bookedSeats = [];
//   Map<String, DateTime> bookedSeats = {};

//   SeatProvider() {
//     _loadBookedSeats();
//   }

//   // void bookSeat(String seat) {
//   //   bookedSeats.add(seat);
//   //   notifyListeners();
//   // }
//   // Book a seat and store the timestamp
//   void bookSeat(String seat) async {
//     DateTime now = DateTime.now();
//     bookedSeats[seat] = now;
//     notifyListeners();
//     await _saveBookedSeats(); // Save the booking information locally
//   }

//   // Check if the seat is booked within the last 12 hours
//   bool isSeatBooked(String seat) {
//     if (bookedSeats.containsKey(seat)) {
//       DateTime bookedTime = bookedSeats[seat]!;
//       if (DateTime.now().difference(bookedTime).inHours < 12) {
//         return true; // Seat is still booked
//       } else {
//         bookedSeats.remove(seat); // Remove expired booking
//         _saveBookedSeats();
//       }
//     }
//     return false;
//   }

//   // Load booked seats from SharedPreferences
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

//   // Save booked seats to SharedPreferences
//   Future<void> _saveBookedSeats() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Map<String, String> stringSeats =
//         bookedSeats.map((seat, time) => MapEntry(seat, time.toIso8601String()));
//     await prefs.setString('bookedSeats', jsonEncode(stringSeats));
//   }
// }

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

// String apiUrl = "http://192.168.1.7:3000/book-seat";

// Future<void> sendSeatToBackend(String seat) async {
//   final response = await http.post(
//     Uri.parse(apiUrl),
//     headers: {
//       "Content-Type": "application/json",
//     },
//     body: jsonEncode({
//       "seatNumber": seat,
//     }),
//   );

//   if (response.statusCode == 200) {
//     print("Seat $seat booked successfully");
//   } else {
//     print("Failed to book seat $seat");
//   }
// }

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
        // home: Parkingscreen(
        //   email: "arun@comcast.com",
        // ),
      ),
    );
  }
}
