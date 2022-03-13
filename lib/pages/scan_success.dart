import 'package:flutter/material.dart';
import 'package:konseki_app/main.dart';

class ScanSuccess extends StatelessWidget {
  final groupName;
  ScanSuccess(String this.groupName);

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
                "Yay! You have joined",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              Text(
                groupName,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/icons/check-illustration.png"),
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
