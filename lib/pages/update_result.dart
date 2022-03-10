import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:konseki_app/main.dart';
import 'package:konseki_app/pages/home.dart';

class UpdateResult extends StatefulWidget {
  const UpdateResult({Key? key}) : super(key: key);

  @override
  State<UpdateResult> createState() => _UpdateResultState();
}

class _UpdateResultState extends State<UpdateResult> {
  var formChoices = {
    0: {
      "bgColorNegative": MaterialStateProperty.all(Colors.transparent),
      "fgColorNegative": MaterialStateProperty.all(Colors.blue),
      "bgColorPositive": MaterialStateProperty.all(Colors.transparent),
      "fgColorPositive": MaterialStateProperty.all(Colors.red),
    },
    1: {
      "bgColorNegative": MaterialStateProperty.all(Colors.blue),
      "fgColorNegative": MaterialStateProperty.all(Colors.white),
      "bgColorPositive": MaterialStateProperty.all(Colors.transparent),
      "fgColorPositive": MaterialStateProperty.all(Colors.red),
    },
    2: {
      "bgColorNegative": MaterialStateProperty.all(Colors.transparent),
      "fgColorNegative": MaterialStateProperty.all(Colors.blue),
      "bgColorPositive": MaterialStateProperty.all(Colors.red),
      "fgColorPositive": MaterialStateProperty.all(Colors.white),
    },
  };

  final choiceMap = {
    0: "",
    1: "negaitve",
    2: "positive",
  };

  var chosenNumber = 0;

  void _confirmation(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (_) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  "You cannot change this after it is submitted!",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm Result'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    title: "",
                  ),
                ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Update Results",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  height: 290,
                  padding: const EdgeInsets.all(37),
                  child: SvgPicture.asset(
                    "assets/icons/test_icon.svg",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Your latest result",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          chosenNumber = chosenNumber != 1 ? 1 : 0;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7 * 0.3,
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Negative",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              formChoices[chosenNumber]!["fgColorNegative"],
                          backgroundColor:
                              formChoices[chosenNumber]!["bgColorNegative"]),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          chosenNumber = chosenNumber != 2 ? 2 : 0;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7 * 0.3,
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Positive",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              formChoices[chosenNumber]!["fgColorPositive"],
                          backgroundColor:
                              formChoices[chosenNumber]!["bgColorPositive"]),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Remember to wait 15 minutes before noting the results!",
                  style: TextStyle(fontSize: 14),
                ),
                const Text(
                  "This is valid for 24 hours.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: chosenNumber == 0
                      ? null
                      : () {
                          _confirmation(context);
                        },
                  child: Container(
                    width: 325,
                    height: 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Submit",
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
      ),
    );
  }
}
