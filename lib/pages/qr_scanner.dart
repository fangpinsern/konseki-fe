import 'package:flutter/material.dart';
import 'package:konseki_app/pages/scan_success.dart';
import 'package:konseki_app/providers/event.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QRScanner extends StatefulWidget {
  final double height;
  final double width;
  QRScanner({Key? key, required this.height, required this.width})
      : super(key: key);

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
      return false;
    }
    final joinInfo =
        await Provider.of<Events>(context, listen: false).joinEvent(eventId);

    if (!joinInfo.isSuccess) {
      return false;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScanSuccess(joinInfo.title, joinInfo.creatorName),
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
            child: const SizedBox(
              height: 280,
              width: 280,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                "Scan event QR Code",
                style: Theme.of(context).textTheme.headline2!.apply(
                      color: Colors.white,
                    ),
              ),
              // Text(val),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScanSuccess("val", "Johnnyboi"),
                    ),
                  );
                },
                child: const Text("To success"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
