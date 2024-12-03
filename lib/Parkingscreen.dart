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
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      getSlotDetails();
    });
  }

  // Fetch the slot details from API
  Future<void> getSlotDetails() async {
    var op = "https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/get_all";
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 10) ,child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      _buildStatusContainer('Available', Colors.green, '', false),
                       _buildStatusContainer('Booked', Colors.orange, 'assets/slot3.jpg', true),
                      _buildStatusContainer('Parked', Colors.red, 'assets/slot3.jpg', false),
                  ],
                ),
                SizedBox(height: 20,)              ],
            ),),
            
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
                    final status = provider.getSeatStatus(seat); // "booked", "parked", or "available"
                    final isBooked = status == "booked";
                    final isParked = status == "parked";
                    final isSelected = provider.selectedSeat == seat;
                    final borderColor = isBooked ? Colors.orange : (isParked ? Colors.red : Colors.green);
                    print("Booked is $isBooked, Parked is $isParked");
                    return GestureDetector(
                      onTap: () {
                        if (!isBooked && !isParked) {
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
                                    ? Colors.blue
                                    : Colors.white,
                          ),
                          child: Center(
                            child: isBooked
                                ? Stack(
                                    children: [
                                      Image.asset(
                                        'assets/slot3.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Colors.black.withOpacity(0.7), Colors.grey.withOpacity(0.6)],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : isParked
                                    ? Image.asset(
                                        'assets/slot3.jpg', // "Parked" status without gray overlay
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

  Widget _buildStatusContainer(String status, Color borderColor, String imagePath, bool hasOverlay){
    bool _iscolor = true;
    if (status =='available'){
      _iscolor=false;
    }
    return Container(
    width: (MediaQuery.of(context).size.width - 90) / 3,  // Matching width with grid item width
    height: 50,  // Keeping the height consistent with the grid item height
    margin: EdgeInsets.all(10.0),
    child: CustomPaint(
      painter: DottedBorderPainter(borderColor), // Using the same DottedBorderPainter
      child: Stack(
        children: [
          if (imagePath.isNotEmpty)
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              // width: MediaQuery.of(context).size.width - 100,
              // height: double.infinity,
            ),
          if (hasOverlay)
            Container(
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black.withOpacity(0.7), Colors.grey.withOpacity(0.6)])),
            ),
          Center(
            child: Text(
              status,
              style: TextStyle(color:Colors.amber, fontSize: 12, fontWeight: FontWeight.bold),
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

    // Top border
    while (startX < size.width) {
      path.moveTo(startX, 0);
      path.lineTo(startX + dashWidth, 0);
      startX += dashWidth + dashSpace;
    }

    // Right border
    double startY = 0;
    startX = size.width;
    while (startY < size.height) {
      path.moveTo(startX, startY);
      path.lineTo(startX, startY + dashWidth);
      startY += dashWidth + dashSpace;
    }

    // Bottom border
    startX = 0;
    startY = size.height;
    while (startX < size.width) {
      path.moveTo(startX, startY);
      path.lineTo(startX + dashWidth, startY);
      startX += dashWidth + dashSpace;
    }

    // Left border
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
  Map<String, String> seatStatus = {};
  String? selectedSeat;

  // Update the seats dynamically based on the API response
  void updateSeats(List<dynamic> slotData) {
    seats.clear();
    seatStatus.clear();

    for (var slot in slotData) {
      final seat = slot['slot']['S'];
      final status = slot['status']['S'];
      seatStatus[seat] = status;
      seats.add(seat);
    }

    notifyListeners();
  }

  void bookSeat(String seat) async {
    seatStatus[seat] = "booked";
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

  String getSeatStatus(String seat){
    return seatStatus[seat]?? "available";
  }

  bool isSeatBooked(String seat) {
    return seatStatus[seat] == "booked";
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
                    Text('Your slot $seat has been successfully booked &',
                        style: TextStyle(fontSize: 13)),
                        Text('QR code has been generated',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),)
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