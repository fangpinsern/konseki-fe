import 'package:flutter/material.dart';
import 'package:konseki_app/main.dart';

class ScanSuccess extends StatelessWidget {
  final String groupName;
  final String creatorName;
  ScanSuccess(this.groupName, this.creatorName, {Key? key}) : super(key: key);

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
              "Yay! You have joined",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              groupName,
              style: Theme.of(context).textTheme.headline2!.apply(
                    color: Colors.blue,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset("assets/icons/check-illustration.png"),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Created by: $creatorName",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 24,
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
