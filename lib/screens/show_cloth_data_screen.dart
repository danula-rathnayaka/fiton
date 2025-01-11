import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowClothDataScreen extends StatelessWidget {
  const ShowClothDataScreen(
      {super.key, required this.code, required this.closeScreen});

  final String code;
  final Function() closeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              closeScreen();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
                data: code,
                version: QrVersions.auto,
                size: 150.0,
              ),
              const Text(
                "Scanned result shows here.",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                code,
                style: const TextStyle(
                    color: Colors.black87, fontSize: 16, letterSpacing: 1),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  child: const Text(
                    "Copy",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
