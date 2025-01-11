import 'package:fiton/model/Measurements.dart';
import 'package:fiton/screens/qr_scanner_screen.dart';
import 'package:fiton/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class MeasurementsInputScreen extends StatefulWidget {
  const MeasurementsInputScreen({super.key});

  static const measurementPoints = [
    ["height", "Vertical distance between crown to the ground"],
    ["bust girth", "Length around fullest part of chest"],
    ["under bust girth", "Length around below busts"],
    ["waist girth", "Length around waist"],
    ["hip girth", "Length around fullest part of hips"],
    ["inside leg girth", "Length around upper part of leg"],
    ["arm length", "Length from shoulder to wrist"],
    ["neck-base girth", "Measurement around the neck"]
  ];

  @override
  State<MeasurementsInputScreen> createState() =>
      _MeasurementsInputScreenState();
}

class _MeasurementsInputScreenState extends State<MeasurementsInputScreen> {
  int step = 1;
  List<double?> measurements = List<double?>.filled(8, null);

  final TextEditingController _controller = TextEditingController();
  bool isButtonEnabled = false;

  void increment() {
    measurements[step - 1] = double.parse(_controller.text);
    setState(() {
      if (step == 8) {
        Measurement(
            measurements[0]!,
            measurements[1]!,
            measurements[2]!,
            measurements[3]!,
            measurements[4]!,
            measurements[5]!,
            measurements[6]!,
            measurements[7]!);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QrScannerScreen()));
        return;
      }
      step++;
      _controller.clear();
      isButtonEnabled = false;
    });
  }

  void decrement() {
    setState(() {
      if (step == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        return;
      }
      step--;
      _controller.clear();
      isButtonEnabled = false;
    });
  }

  void _checkInput() {
    setState(() {
      isButtonEnabled = double.tryParse(_controller.text) != null;
    });
  }

  void _onSubmitted(String value) {
    if (isButtonEnabled) {
      increment();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Text("${this.step} of 8"),
                const Image(
                  image: AssetImage("assets/welcome_graphic.png"),
                  height: 400,
                  width: 450,
                ),
                const SizedBox(height: 20),
                Text(
                  "What is your ${MeasurementsInputScreen.measurementPoints[step - 1][0]}?",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA337D9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  MeasurementsInputScreen.measurementPoints[step - 1][1],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter measurement (cm)',
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      _checkInput();
                    },
                    onSubmitted: _onSubmitted,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        decrement();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        backgroundColor: Colors.white,
                        // White background for Back button
                        foregroundColor: const Color(0xFF800080),
                        // Purple text color
                        side: const BorderSide(
                            color: const Color(0xFF800080), width: 2),
                        // Purple border
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_rounded, size: 24),
                          // Purple arrow icon
                          SizedBox(width: 5),
                          Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Next Button
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              increment();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        backgroundColor: const Color(0xFF800080),
                        // Purple background
                        foregroundColor: Colors.white,
                        // White text color
                        shadowColor: Colors.black45,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward_rounded, size: 24),
                          // White arrow icon
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
