
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  late String trial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        actions: [
          IconButton(
            onPressed: () {
              // Additional logic if needed
            },
            icon: const Icon(Icons.qr_code),
          ),
        ],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;

          for (final barcode in barcodes) {
            print('Barcode found! ${barcode.rawValue}');
          }

          if (image != null) {
            showDialog(
              context: context,
              builder: (context) {
                trial = barcodes.first.rawValue ?? "";
                print(trial);
                print(trial);

                // Parse the raw QR data into a map
                Map<String, String> parsedData = parseQRData(trial);

                return AlertDialog(
                  // title: Text(barcodes.first.rawValue ?? ""),
                  content: Column(
                    children: [
                      Text(barcodes.first.rawValue ?? ""),
                      SizedBox(height: 10),
                      Image(image: MemoryImage(image)),
                      SizedBox(height: 40),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _parkingqrfunction();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Confirm',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.black26;
                              }
                              return Colors.green;
                            }),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Function to parse the raw QR data into a Map
  Map<String, String> parseQRData(String rawData) {
    Map<String, String> parsedData = {};
    // Example: "Employee:Arun, Slot:1D, email:arun@gmail.com"
    List<String> entries = rawData.split(','); // Split by comma

    for (String entry in entries) {
      List<String> keyValue = entry.split(':'); // Split by colon
      if (keyValue.length == 2) {
        parsedData[keyValue[0].trim()] = keyValue[1].trim(); // Add to map
      }
    }

    return parsedData;
  }

  Future<void> _parkingqrfunction() async {
    final response = await http.post(
    Uri.parse('https://5757r0zixi.execute-api.us-east-1.amazonaws.com/v1/scan'),
    headers: {"Content-Type": "application/json"},
    body: trial,
  );
  if (response.statusCode == 200) {
    print(response.body);
    _showSuccessDialog(context, response.body);
  }
  else{
    print(response.body);
    _showFailureDialog(context, response.body);
  }
  }
  void _showSuccessDialog(BuildContext context, String data) {
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
                    Text('Booking Confirmed!',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('$data',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),)
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
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
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

}
