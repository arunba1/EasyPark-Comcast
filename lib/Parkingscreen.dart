// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class Parkingscreen extends StatefulWidget {
//   final String email;

//   const Parkingscreen({Key? key, required this.email}) : super(key: key);

//   @override
//   _ParkingscreenState createState() => _ParkingscreenState();
// }

// class _ParkingscreenState extends State<Parkingscreen> {

//   late String username;
//   late String user;

//   late List<dynamic>seatdisplay;

//   @override
//   void initState() {
//     super.initState();
//     username = widget.email.split('@')[0];
//     user = username[0].toUpperCase() + username.substring(1);

//     getslotdetails();
//     Timer.periodic(Duration(seconds: 30), (Timer timer){
//       getslotdetails();
//     });

//   }

//   void getslotdetails(){
//     var op = "https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/get_all";
//     http.get(Uri.parse(op)).then((response){
//       print(response.body);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SeatProvider>(context);
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Color.fromRGBO(0,0,139,0.87),
//           iconTheme: IconThemeData(color: Colors.white),
//           title: Text(
//             'Book Your Slot $user',
//             style: TextStyle(
//                 fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
//           ),
//         ),
//         body:  
//         GestureDetector(
//           onTap: () {
//           provider.clearSelectedSeat(); // Clear selection when tapping outside
//         },
//           child: Column(children: [
//             SizedBox(
//               height: 2,
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Parkingscreen(email: widget.email),
//                             ));
//                       },
//                       child: Text('1st Floor')),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   ElevatedButton(onPressed: () {}, child: Text('2nd Floor')),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   ElevatedButton(onPressed: () {}, child: Text('3rd Floor')),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   ElevatedButton(onPressed: () {}, child: Text('4th Floor')),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child:Padding(padding: EdgeInsets.only(left: 10, right: 10) , child: 
//               GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 2,
//                   mainAxisSpacing: 40,
//                   crossAxisSpacing: 100,
//                 ),
//                 itemCount: provider.seats.length,
//                 itemBuilder: (context, index) {
//                   final seat = provider.seats[index];
//                   final isBooked = provider.isSeatBooked(seat);
//                   final isSelected = provider.selectedSeat == seat;
//                   final borderColor = isBooked ? Colors.red : Colors.green;
//                   return GestureDetector(
//                     onTap: () {
//                       if (!isBooked) {
//                         provider.selectSeat(seat); // Select the seat
//                       }
//                     },
//                     child: CustomPaint(
//                       painter: DottedBorderPainter(
//                           borderColor), // Custom painter for dotted border
//                       child: Container(
//                         margin: EdgeInsets.all(4.0),
//                         decoration: BoxDecoration(
//                           color: isBooked
//                               ? Colors.white12
//                               : isSelected
//                                   ? Colors.yellow
//                                   : Colors.white,
//                         ),
//                         child: Center(
//                           child: isBooked
//                               ? Image.asset(
//                                   'assets/slot3.jpg',
//                                   fit: BoxFit.fill,
//                                 )
//                               : Text(
//                                   seat,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                     // isSelected ? Colors.black : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),)
//             ),
//             SizedBox(height: 20),
            
//              if (provider.selectedSeat != null) // Only show the button if a seat is selected
//               Container(
//                  width: MediaQuery.of(context).size.width,
//                 height: 50,
//                 margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
//                 child: ElevatedButton(
//                   onPressed: () async {
//                      if (provider.selectedSeat != null) {
//                       await sendSeatToBackend(context, provider.selectedSeat!, widget.email);
//                     }
//                   },
//                   child: Text('Book' ,style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18)),
//                          style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.resolveWith((states) {
//                       if (states.contains(WidgetState.pressed)) {
//                         return Colors.black26;
//                       }
//                       return Colors.green;
//                     }),
//                     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30)))),
//                 ),
//               ),
//           ]),
//         ));
//   }
// }

// // Create a custom painter for the dotted border
// class DottedBorderPainter extends CustomPainter {
//   final Color bordercolor;
//   DottedBorderPainter(this.bordercolor);

//   // DottedBorderPainter(this.borderColor);
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = bordercolor
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     double dashWidth = 7, dashSpace = 3;
//     double startX = 0;
//     final path = Path();

//     // Draw top border
//     while (startX < size.width) {
//       path.moveTo(startX, 0);
//       path.lineTo(startX + dashWidth, 0);
//       startX += dashWidth + dashSpace;
//     }

//     // Draw right border
//     double startY = 0;
//     startX = size.width;
//     while (startY < size.height) {
//       path.moveTo(startX, startY);
//       path.lineTo(startX, startY + dashWidth);
//       startY += dashWidth + dashSpace;
//     }

//     // Draw bottom border
//     startX = 0;
//     startY = size.height;
//     while (startX < size.width) {
//       path.moveTo(startX, startY);
//       path.lineTo(startX + dashWidth, startY);
//       startX += dashWidth + dashSpace;
//     }

//     // Draw left border
//     startY = 0;
//     startX = 0;
//     while (startY < size.height) {
//       path.moveTo(startX, startY);
//       path.lineTo(startX, startY + dashWidth);
//       startY += dashWidth + dashSpace;
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
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
//   String? selectedSeat;

//   SeatProvider() {
//     // _loadBookedSeats();
//   }

//   void bookSeat(String seat) async {
//     DateTime now = DateTime.now();
//     bookedSeats[seat] = now;
//     notifyListeners();
//     // await _saveBookedSeats();
//   }

//   void selectSeat(String seat) {
//     selectedSeat = seat;
//     notifyListeners();
//   }

//   void clearSelectedSeat() {
//     selectedSeat = null;
//     notifyListeners();
//   }

//   bool isSeatBooked(String seat) {
//     return bookedSeats.containsKey(seat);
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
    
//     // After successful API response, perform state changes:
//     _showSuccessDialog(context, seat);
//     // Mark seat as booked
//     context.read<SeatProvider>().bookSeat(seat); 
//     // Clear the selected seat
//     context.read<SeatProvider>().clearSelectedSeat();
//   } else {
//     print("Failed to book slot: ${response.body}");
//     _showFailureDialog(context, response.body);
//   }

//     }
//   void _showSuccessDialog(BuildContext context, String seat) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: Container(
//           width: double.maxFinite, // Use maximum width
//           height: 100, // Set height as needed
//           child: Row(
//             children: [
//               // Image on the left
//               LottieBuilder.asset(
//                 'assets/Animation - success.json', // Your success image
//                 width: 80, // Adjust width as needed
//                 height: 90, // Adjust height as needed
//                 fit: BoxFit.cover,
//               ),
//               SizedBox(width: 16), // Space between image and text
//               // Success message on the right
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Booking Successful!',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'Your slot $seat has been successfully booked',
//                       style: TextStyle(fontSize: 13),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }

// void _showFailureDialog(BuildContext context, String seat) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: Container(
//           width: double.maxFinite, // Use maximum width
//           height: 100, // Set height as needed
//           child: Row(
//             children: [
//               // Image on the left
//               LottieBuilder.asset(
//                 'assets/Animation-wrong.json', // Your success image
//                 width: 80, // Adjust width as needed
//                 height: 90, // Adjust height as needed
//                 fit: BoxFit.cover,
//               ),
//               SizedBox(width: 16), // Space between image and text
//               // Success message on the right
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '$seat!',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Parkingscreen extends StatefulWidget {
  final String email;

  const Parkingscreen({Key? key, required this.email}) : super(key: key);

  @override
  _ParkingscreenState createState() => _ParkingscreenState();
}

class _ParkingscreenState extends State<Parkingscreen> {
  late String username;
  late String user;

  @override
  void initState() {
    super.initState();
    username = widget.email.split('@')[0];
    user = username[0].toUpperCase() + username.substring(1);

    // Fetch slot details initially and refresh periodically
    getSlotDetails();
    Timer.periodic(Duration(seconds: 30), (Timer timer) {
      getSlotDetails();
    });
  }

  // Fetch the slot details from API
  Future<void> getSlotDetails() async {
    var op = "https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/get_all"; // replace with your actual API URL
    try {
      final response = await http.get(Uri.parse(op));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Update the provider with fetched data
        context.read<SeatProvider>().updateSeats(data);
      } else {
        print("Failed to load slots: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching slot details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SeatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 139, 0.87),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Book Your Slot $user',
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          provider.clearSelectedSeat(); // Clear selection when tapping outside
        },
        child: Column(
          children: [
            SizedBox(height: 2),
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
                          builder: (context) => Parkingscreen(email: widget.email),
                        ),
                      );
                    },
                    child: Text('1st Floor'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: () {}, child: Text('2nd Floor')),
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: () {}, child: Text('3rd Floor')),
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: () {}, child: Text('4th Floor')),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    mainAxisSpacing: 40,
                    crossAxisSpacing: 100,
                  ),
                  itemCount: provider.seats.length,
                  itemBuilder: (context, index) {
                    final seat = provider.seats[index];
                    final isBooked = provider.isSeatBooked(seat);
                    final isSelected = provider.selectedSeat == seat;
                    final borderColor = isBooked ? Colors.red : Colors.green;

                    return GestureDetector(
                      onTap: () {
                        if (!isBooked) {
                          provider.selectSeat(seat); // Select the seat
                        }
                      },
                      child: CustomPaint(
                        painter: DottedBorderPainter(borderColor),
                        child: Container(
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: isBooked
                                ? Colors.white12
                                : isSelected
                                    ? Colors.yellow
                                    : Colors.white,
                          ),
                          child: Center(
                            child: isBooked
                                ? Image.asset(
                                    'assets/slot3.jpg',
                                    fit: BoxFit.fill,
                                  )
                                : Text(
                                    seat,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (provider.selectedSeat != null) // Only show the button if a seat is selected
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  onPressed: () async {
                    if (provider.selectedSeat != null) {
                      await sendSeatToBackend(context, provider.selectedSeat!, widget.email);
                    }
                  },
                  child: Text(
                    'Book',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.black26;
                      }
                      return Colors.green;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Create a custom painter for the dotted border
class DottedBorderPainter extends CustomPainter {
  final Color borderColor;
  DottedBorderPainter(this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 7, dashSpace = 3;
    double startX = 0;
    final path = Path();

    // Draw top border
    while (startX < size.width) {
      path.moveTo(startX, 0);
      path.lineTo(startX + dashWidth, 0);
      startX += dashWidth + dashSpace;
    }

    // Draw right border
    double startY = 0;
    startX = size.width;
    while (startY < size.height) {
      path.moveTo(startX, startY);
      path.lineTo(startX, startY + dashWidth);
      startY += dashWidth + dashSpace;
    }

    // Draw bottom border
    startX = 0;
    startY = size.height;
    while (startX < size.width) {
      path.moveTo(startX, startY);
      path.lineTo(startX + dashWidth, startY);
      startX += dashWidth + dashSpace;
    }

    // Draw left border
    startY = 0;
    startX = 0;
    while (startY < size.height) {
      path.moveTo(startX, startY);
      path.lineTo(startX, startY + dashWidth);
      startY += dashWidth + dashSpace;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SeatProvider with ChangeNotifier {
  List<String> seats = [];
  Map<String, DateTime> bookedSeats = {};
  String? selectedSeat;

  // Update the seats dynamically based on the API response
  void updateSeats(List<dynamic> slotData) {
    seats.clear();
    bookedSeats.clear();

    for (var slot in slotData) {
      final seat = slot['slot']['S'];
      final status = slot['status']['S'];

      if (status == 'booked') {
        bookedSeats[seat] = DateTime.now();
      }
      seats.add(seat);
    }

    notifyListeners();
  }

  void bookSeat(String seat) async {
    DateTime now = DateTime.now();
    bookedSeats[seat] = now;
    notifyListeners();
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
    return bookedSeats.containsKey(seat);
  }
}

Future<void> sendSeatToBackend(BuildContext context, String seat, String email) async {
  final response = await http.post(
    Uri.parse('https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/book_slot'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "slot": seat}),
  );
  if (response.statusCode == 200) {
    print(response.body);

    // After successful API response, perform state changes
    _showSuccessDialog(context, seat);
    context.read<SeatProvider>().bookSeat(seat);
    context.read<SeatProvider>().clearSelectedSeat();
  } else {
    print("Failed to book slot: ${response.body}");
    _showFailureDialog(context, response.body);
  }
}

void _showSuccessDialog(BuildContext context, String seat) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: double.maxFinite,
          height: 100,
          child: Row(
            children: [
              LottieBuilder.asset(
                'assets/Animation - success.json',
                width: 80,
                height: 90,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Booking Successful!',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Text('Your slot $seat has been successfully booked',
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showFailureDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: double.maxFinite,
          height: 100,
          child: Row(
            children: [
              LottieBuilder.asset(
                'assets/Animation-wrong.json',
                width: 80,
                height: 90,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
