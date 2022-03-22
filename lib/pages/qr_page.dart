import 'package:flutter/material.dart';
import 'package:konseki_app/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  final String groupName;
  late String groupLink;

  QRPage({Key? key, required this.groupName, required eventId})
      : super(key: key) {
    groupLink = "https://google.com?eventId=$eventId";
  }

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Text(
              "Share QR code for",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              widget.groupName,
              style: Theme.of(context).textTheme.headline2!.apply(
                    color: Colors.blue,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            QrImage(
                data: widget.groupLink,
                size: 325,
                foregroundColor: const Color.fromRGBO(0, 92, 178, 1)),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    index: 2,
                  ),
                ));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 48,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Done",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
