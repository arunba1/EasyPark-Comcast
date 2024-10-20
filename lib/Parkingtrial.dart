import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingSlotScreen extends StatefulWidget {
  @override
  _ParkingSlotScreenState createState() => _ParkingSlotScreenState();
}

class _ParkingSlotScreenState extends State<ParkingSlotScreen> {
  String selectedSlot = '';
  List<String> bookedSlots = ['A0'];

  void selectSlot(String slot) {
    if (!bookedSlots.contains(slot)) {
      setState(() {
        selectedSlot = slot;
      });
    }
  }

  void proceedWithSlot() async {
    final response = await http.post(
        Uri.parse(
            'https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/book_slot'),
        // body: {'slot': selectedSlot},
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": "arun@comcast.com", "slot": selectedSlot}));
    if (response.statusCode == 200) {
      // Handle successful response
      print('Proceed with $selectedSlot slot');
      bookedSlots.add(selectedSlot);
      print(bookedSlots);
    } else {
      // Handle error response
      print('Failed to book slot $selectedSlot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your Slot'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('1st Floor')),
                ElevatedButton(onPressed: () {}, child: Text('2nd Floor')),
                ElevatedButton(onPressed: () {}, child: Text('3rd Floor')),
                // ElevatedButton(onPressed: () {}, child: Text('4th Floor')),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
              ),
              itemCount: 18,
              itemBuilder: (context, index) {
                String slot = index < 9 ? 'A$index' : 'B${index - 9}';
                bool isBooked = bookedSlots.contains(slot);
                return GestureDetector(
                  onTap: () {
                    selectSlot(slot);
                  },
                  child: Container(
                    margin: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color:
                          selectedSlot == slot ? Colors.yellow : Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: isBooked
                          // ? Icon(Icons.directions_car, color: Colors.black)
                          ? Image.asset('assets/slot2.jpg')
                          : Text(slot),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedSlot.isNotEmpty ? proceedWithSlot : null,
            child: Text('Proceed with $selectedSlot slot'),
          ),
        ],
      ),
    );
  }
}
