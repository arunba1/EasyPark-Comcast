import 'package:car_parking_system/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Parkingscreen extends StatelessWidget {
  final String email;

  const Parkingscreen({Key? key, required this.email}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String username = email.split('@')[0];
    String user = username[0].toUpperCase() + username.substring(1);
    final provider = Provider.of<SeatProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0,0,139,0.87),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Book Your Slot $user',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        body:  
        GestureDetector(
          onTap: () {
          provider.clearSelectedSeat(); // Clear selection when tapping outside
        },
          child: Column(children: [
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
              height: 20,
            ),
            Expanded(
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
                      painter: DottedBorderPainter(
                          borderColor), // Custom painter for dotted border
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
                                    // isSelected ? Colors.black : Colors.black,
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
            SizedBox(height: 20),
            
             if (provider.selectedSeat != null) // Only show the button if a seat is selected
              Container(
                 width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  onPressed: () async {
                    await sendSeatToBackend(
                        context, provider.selectedSeat!, email);
                    provider.bookSeat(provider.selectedSeat!); // Mark the seat as booked
                    provider.clearSelectedSeat(); // Clear the selection
                  },
                  child: Text('Book' ,style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                         style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.black26;
                      }
                      return Colors.green;
                    }),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                ),
              ),
          ]),
        ));
  }
}

// Create a custom painter for the dotted border
class DottedBorderPainter extends CustomPainter {
  final Color bordercolor;
  DottedBorderPainter(this.bordercolor);

  // DottedBorderPainter(this.borderColor);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bordercolor
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
    _showSuccessDialog(context, seat);
  } else {
    final responsedata = jsonDecode(response.body);
    final message = responsedata['message'];
    print("Failed to book seat $seat");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(message)),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
    }
  void _showSuccessDialog(BuildContext context, String seat) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: double.maxFinite, // Use maximum width
          height: 100, // Set height as needed
          child: Row(
            children: [
              // Image on the left
              LottieBuilder.asset(
                'assets/Animation - success.json', // Your success image
                width: 80, // Adjust width as needed
                height: 90, // Adjust height as needed
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16), // Space between image and text
              // Success message on the right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Booking Successful!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your slot $seat has been successfully booked',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
