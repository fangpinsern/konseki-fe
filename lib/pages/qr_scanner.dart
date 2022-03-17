import 'package:flutter/material.dart';
import 'package:konseki_app/pages/scan_success.dart';
import 'package:konseki_app/providers/event.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QRScanner extends StatefulWidget {
  final double height;
  final double width;
  QRScanner({required double this.height, required double this.width});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  // var val = "Text appear here";
  var backgroundC = Colors.grey.withOpacity(0.7);

  Future<bool> _joinEvent(String code) async {
    final uri = Uri.parse(code);
    final eventId = uri.queryParameters['eventId'];
    if (eventId == null) {
      // show error page
      print("FAILED1");
      return false;
    }
    final joinInfo =
        await Provider.of<Events>(context, listen: false).JoinEvent(eventId);

    if (!joinInfo.isSuccess) {
      print("FAILED2");
      return false;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScanSuccess(joinInfo.title),
      ),
    );
    return false;
  }

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
            if (code == null) {
              // show error
              print("FAILED");
              return;
            }
            _joinEvent(code);
            //join event
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
              ),
              // Text(val),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScanSuccess("val"),
                    ),
                  );
                },
                child: Text("To success"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
