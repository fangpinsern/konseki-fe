import 'package:flutter/material.dart';
import 'package:konseki_app/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  final groupName;
  final groupLink;

  const QRPage({Key? key, required this.groupName, required this.groupLink})
      : super(key: key);

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const Text(
                "Join group:",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              Text(
                widget.groupName,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              QrImage(
                data: widget.groupLink,
                size: 280,
              ),
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 48,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Done",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
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
