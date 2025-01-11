import 'package:fiton/screens/show_cloth_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCam = false;

  MobileScannerController controller = MobileScannerController();

  void closeScan() {
    isScanCompleted = false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(isFlashOn ? Icons.flash_off : Icons.flash_on,
                  color: isFlashOn ? Colors.blue : Colors.grey)),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCam = !isFrontCam;
                });
                controller.switchCamera();
              },
              icon: const Icon(Icons.camera_front, color: Colors.grey))
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
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
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Place the QR code in the area.",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(height: 10),
                Text(
                  "Scanning will be started automatically.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )
              ],
            )),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    MobileScanner(
                      onDetect: (BarcodeCapture barcodeCapture) {
                        if (!isScanCompleted) {
                          for (var barcode in barcodeCapture.barcodes) {
                            String code = barcode.rawValue ?? "___";
                            isScanCompleted = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowClothDataScreen(
                                          closeScreen: closeScan,
                                          code: code,
                                        )));
                          }
                        }
                      },
                      controller: controller,
                    ),
                    QRScannerOverlay(
                        scanAreaWidth: 250,
                        scanAreaHeight: 250,
                        borderColor: Colors.purple),
                  ],
                )),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Developed by Fit On.",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          letterSpacing: 1),
                    ))),
          ],
        ),
      ),
    );
  }
}
