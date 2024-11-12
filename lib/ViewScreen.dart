// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui';

// import 'package:velocity_x/velocity_x.dart';

// class ViewScreen extends StatefulWidget {
//   final String email;  // You can pass email as a parameter if necessary
//   ViewScreen({super.key, required this.email});

//   @override
//   State<ViewScreen> createState() => _ViewScreenState();
// }

// class _ViewScreenState extends State<ViewScreen> {
//   String selectedSlot = ''; 
//   bool isLoading = false; 
//   String errorMessage = '';
//   late List<dynamic> apiResponse;
//   String? selslot;

//   @override
//   void initState() {
//     super.initState();
//     fetchSlot();
//   }

//   Future<void> fetchSlot() async {
//     setState(() {
//       isLoading = true; 
//     });

//     try {
//       final response = await http.post(
//         Uri.parse('https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/my_slot'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "email": widget.email,
//         }),
//       );

//       if (response.statusCode == 200) {
//         apiResponse = jsonDecode(response.body);
//         setState(() {
//           selslot = apiResponse[0]['slot']['S'];  
//           isLoading = false; 
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Failed to fetch slot data';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error: $e';
//         isLoading = false;
//       });
//     }
//   }

//   String deleteurl = "https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/delete_slot"; 
// Future<void> delete(String slot) async {
//   setState(() {
//     isLoading = true;
//   });

//   try {
//     final response = await http.post(
//       Uri.parse(deleteurl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"slot": slot}),
//     );

//     if (response.statusCode == 200) {
//       print(response.statusCode);
//       print(response.body);
//       setState(() {
//         selslot = null;
//         isLoading = false; 
//       });
//     } else {
//       setState(() {
//         errorMessage = 'Failed to delete the slot';
//         isLoading = false;
//       });
//     }
//   } catch (e) {
//     setState(() {
//       errorMessage = 'Error: $e';
//       isLoading = false;
//     });
//   }
// }
//   String getFormattedDate() {
//     final now = DateTime.now();
//     final dayFormatter = DateFormat('d');
//     final monthFormatter = DateFormat('MMM');
//     final weekdayFormatter = DateFormat('EEEE');

//     String daySuffix;
//     switch (dayFormatter.format(now).toString()) {
//       case '1':
//       case '21':
//       case '31':
//         daySuffix = 'st';
//         break;
//       case '2':
//       case '22':
//         daySuffix = 'nd';
//         break;
//       case '3':
//       case '23':
//         daySuffix = 'rd';
//         break;
//       default:
//         daySuffix = 'th';
//     }

//     return '${dayFormatter.format(now)}$daySuffix ${monthFormatter.format(now)}, ${weekdayFormatter.format(now)}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('View My Slot'),
//         backgroundColor: const Color.fromRGBO(0, 0, 139, 0.87),
//         foregroundColor: const Color.fromRGBO(252, 252, 252, 0.867),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//             ),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//               child: Container(
//                 color: Colors.white.withOpacity(0.3),
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Transform.translate(
//                   offset: const Offset(-110, 30),
//                   child: Text(
//                     getFormattedDate(),
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Oxanium',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 GFCard(
//                   boxFit: BoxFit.cover,
//                   height: 230,
//                   elevation: 9,
//                   color: const Color.fromARGB(255, 240, 239, 239),
//                   margin: const EdgeInsets.all(20),
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(
//                       color: Color.fromRGBO(0, 0, 139, 0.87),
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   title: GFListTile(
//                     title: Row(
//                       children: [
//                         Transform.translate(
//                           offset: const Offset(-25, 0),
//                           child: const Icon(
//                             Icons.location_on,
//                             size: 25,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Transform.translate(
//                             offset: const Offset(-35, 0),
//                             child: const Text(
//                               'Comcast India Engineering Center',
//                               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     subTitle: Padding(
//                       padding: const EdgeInsets.only(left: 25, top: 30),
//                       child: isLoading
//                           ? const CircularProgressIndicator()
//                           : Text(
//                               selslot != null
//                                   ? 'Slot Booked: $selslot'
//                                   : 'No slot available',
//                               style: const TextStyle(fontSize: 15),
//                             ),
//                     ),
//                   ),
//                   content: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: const Color.fromARGB(255, 221, 223, 214),
//                           shape: RoundedRectangleBorder(
//                             side: const BorderSide(
//                               color: Color.fromRGBO(0, 0, 139, 0.87),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.edit,  
//                               color: Colors.black,
//                               size: 18,  
//                             ),
//                             SizedBox(width: 6), 
//                             Text('Edit', style: TextStyle(color: Colors.black)),
//                           ],
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           delete(selslot!);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: const Color.fromARGB(255, 221, 223, 214),
//                           shape: RoundedRectangleBorder(
//                             side: const BorderSide(
//                               color: Color.fromRGBO(0, 0, 139, 0.87),
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.cancel,  
//                               color: Colors.black,
//                               size: 18, 
//                             ),
//                             SizedBox(width: 6),
//                             Text('Cancel', style: TextStyle(color: Colors.black)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
 
class ViewScreen extends StatefulWidget {
  final String email;  // You can pass email as a parameter if necessary
  ViewScreen({super.key, required this.email});
 
  @override
  State<ViewScreen> createState() => _ViewScreenState();
}
 
class _ViewScreenState extends State<ViewScreen> {
  String selectedSlot = '';
  bool isLoading = false;
  String errorMessage = '';
  late List<dynamic> apiResponse;
  String? selslot;
 
  @override
  void initState() {
    super.initState();
    fetchSlot();
  }
 
  Future<void> fetchSlot() async {
    setState(() {
      isLoading = true;  // Show loading indicator while fetching data
    });
 
    try {
      final response = await http.post(
        Uri.parse('https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/my_slot'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": widget.email,
        }),
      );
 
      if (response.statusCode == 200) {
        apiResponse = jsonDecode(response.body);
        setState(() {
          selslot = apiResponse[0]['slot']['S'];  
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch slot data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }
 
  String deleteurl = "https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/delete_slot";
  Future<void> delete(String slot) async {
    setState(() {
      isLoading = true;
    });
 
    try {
      final response = await http.post(
        Uri.parse(deleteurl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"slot": slot}),
      );
 
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        setState(() {
          selslot = null;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to delete the slot';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }
 
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
        title: const Text('View My Slot'),
        backgroundColor: const Color.fromRGBO(0,0,139,0.87),
        foregroundColor: Colors.white,
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Blur with Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color.fromARGB(255, 215, 211, 215).withOpacity(0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.white.withOpacity(0.3)),
            ),
          ),
         
          // Centered content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-105, 50),
                  child: Text(
                    getFormattedDate(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oxanium',
                    ),
                  ),
                ),
                const SizedBox(height: 70),
 
                // Slot Info Card
                GFCard(
                  boxFit: BoxFit.cover,
                  elevation: 12,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromRGBO(0, 0, 139, 0.87),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: GFListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.location_on, color: Color.fromRGBO(0, 0, 139, 0.87), size: 14),
                        SizedBox(width: 5),
                        Text('Comcast India Engineering Center', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                    subTitle: Padding(
                      padding: const EdgeInsets.only(left: 25, top: 30),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              selslot != null ? 'Your Slot: $selslot' : 'No slot available',
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Implement Slot Edit Logic
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.deepPurpleAccent,
                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      //     padding: EdgeInsets.all(15),
                      //     elevation: 5,
                      //   ),
                      //   child: const Row(
                      //     children: [
                      //       Icon(Icons.edit, size: 20),
                      //       SizedBox(width: 10),
                      //       Text('Edit Slot', style: TextStyle(fontSize: 16)),
                      //     ],
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          if (selslot != null) {
                            delete(selslot!);
                          }
                        },
                     
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.black, backgroundColor: Colors.white, // Text color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(
        color: Color.fromRGBO(0, 0, 139, 0.87), // Border color
        width: 2, // Border width
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15), // Reduced padding for smaller size
    elevation: 5,
    minimumSize: Size(120, 40), // Reduce the button size (width: 120, height: 40)
  ),
  child: const Row(
    mainAxisSize: MainAxisSize.min, // Ensure the button size is not stretched
    children: [
      Icon(Icons.cancel, size: 15),
      SizedBox(width: 5),
      Text('Cancel', style: TextStyle(fontSize: 16)),
    ],
  ),
),
                    ]
                      ),
   )
   
   ]
            )
          )
        ]
      )
    );
   }
}
 