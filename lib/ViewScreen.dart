import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
 
class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key, required String email});
 
  @override
  State<ViewScreen> createState() => _ViewScreenState();
}
 
class _ViewScreenState extends State<ViewScreen> {
  String getFormattedDate() {
    final now = DateTime.now();
    final dayFormatter = DateFormat('d');
    final monthFormatter = DateFormat('MMM');
    final weekdayFormatter = DateFormat('EEEE');
 
    String daySuffix;
    switch (dayFormatter.format(now).toString()) {
      case '1':
      case '21':
      case '31':
        daySuffix = 'st';
        break;
      case '2':
      case '22':
        daySuffix = 'nd';
        break;
      case '3':
      case '23':
        daySuffix = 'rd';
        break;
      default:
        daySuffix = 'th';
    }
 
    return '${dayFormatter.format(now)}$daySuffix ${monthFormatter.format(now)}, ${weekdayFormatter.format(now)}';
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View My Slot'), backgroundColor:  Color.fromARGB(255, 216, 205, 120),
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
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-110, 30),
                  child: Text(
                    getFormattedDate(),
                    style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Oxanium'),
                  ),
                ),
                const SizedBox(height: 30),
                GFCard(
                  boxFit: BoxFit.cover,
                  height: 230,
                  elevation: 9,
                  color: const Color.fromARGB(255, 250, 250, 250),
                  margin: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 179, 159, 10),
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: GFListTile(
                    title: Row(
                      children: [
                Transform.translate(
     offset: const Offset(-25, 0), // This acts like an offset
      child: const Icon(  
                          Icons.location_on,
                          size: 25,
                          color: Colors.black,
                        ),
    ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Transform.translate(
                          offset: const Offset(-35, 0),
                          child: const Text(           
                            'Comcast India Engineering Center',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ),
                      ],
                    ),
                    subTitle: const Padding(
                      padding: EdgeInsets.only(left: 25, top: 30),
                      child: Text(
                        'Slot Booked:',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Handle the edit action here
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 221, 223, 214), // Text color
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 179, 159, 10), // Border color
                              width: 1, // Border width
                            ),
                            borderRadius: BorderRadius.circular(8), // Button border radius
                          ),
                        ),
                        child: const Text('Edit',style: TextStyle(color: Colors.black)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the delete action here
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 221, 223, 214), // Text color
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color:  Color.fromARGB(255, 179, 159, 10), // Border color
                              width: 1, // Border width
                            ),
                            borderRadius: BorderRadius.circular(10), // Button border radius
                          ),
                        ),
                        child: const Text('Cancel',style: TextStyle(color: Colors.black)),
                      ),
                    ],
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