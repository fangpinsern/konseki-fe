import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:konseki_app/main.dart';
import 'package:konseki_app/providers/event.dart';
import 'package:provider/provider.dart';

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
              onPressed: () async {
                final isSuccess =
                    await Provider.of<Events>(context, listen: false)
                        .updateStatus(chosenNumber == 2, DateTime.now());
                if (isSuccess) {
                  // should change to success failure page
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      index: 0,
                    ),
                  ));
                } else {
                  Navigator.of(context).pop();
                  // move to error page
                }
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
          // width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
            vertical: 0,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    IconButton(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Update result",
                      style: Theme.of(context).textTheme.headline2,
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
                Text(
                  "Your latest result",
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            chosenNumber = chosenNumber != 1 ? 1 : 0;
                          });
                        },
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Negative",
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
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            chosenNumber = chosenNumber != 2 ? 2 : 0;
                          });
                        },
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.9 * 0.3,
                          // constraints: BoxConstraints(
                          //   minWidth: 10,
                          // ),
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Positive",
                              ),
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                            foregroundColor:
                                formChoices[chosenNumber]!["fgColorPositive"],
                            backgroundColor:
                                formChoices[chosenNumber]!["bgColorPositive"]),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Remember to wait 15 minutes before noting the results!",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  "This is valid for 24 hours.",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .apply(color: Colors.grey),
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
                  child: SizedBox(
                    width: 325,
                    height: 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Submit",
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
