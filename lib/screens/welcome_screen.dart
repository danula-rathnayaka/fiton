import 'package:fiton/screens/measurements%20_input_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  SizedBox(height: 10),
                  Image(
                    image: AssetImage("assets/logo.png"),
                    height: 100,
                    width: 150,
                  ),
                  Image(
                    image: AssetImage("assets/welcome_graphic.png"),
                    height: 400,
                    width: 450,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Try Before You Buy, Virtually",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA337D9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Experience your favorite outfits with a perfect virtual fit.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MeasurementsInputScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      backgroundColor: const Color(0xFF800080),
                      foregroundColor: Colors.white,
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
                          "Get Started",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_right_alt_rounded, size: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
