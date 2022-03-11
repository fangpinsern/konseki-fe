import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanner extends StatefulWidget {
  final double height;
  final double width;
  QRScanner({required double this.height, required double this.width});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  var backgroundC = Colors.grey.withOpacity(0.7);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          allowDuplicates: false,
          controller: MobileScannerController(
              facing: CameraFacing.back,
              torchEnabled: false,
              formats: [BarcodeFormat.qrCode]),
          onDetect: (barcode, args) {
            final String? code = barcode.rawValue;
            debugPrint('Barcode found! $code');
          },
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                  vertical: BorderSide(
                    color: backgroundC,
                    width: widget.width,
                  ),
                  horizontal: BorderSide(
                    color: backgroundC,
                    width: widget.height,
                  )),
            ),
            // color: Colors.red,
            child: SizedBox(
              height: 280,
              width: 280,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                "Scan QR Code",
                style: TextStyle(fontSize: 32),
              )
            ],
          ),
        )
      ],
    );
  }
}
