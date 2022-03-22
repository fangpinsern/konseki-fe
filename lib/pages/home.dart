import 'package:flutter/material.dart';
import 'package:konseki_app/pages/new_event.dart';
import 'package:konseki_app/providers/auth.dart';
import 'package:konseki_app/widgets/home/info_section.dart';
import 'package:konseki_app/widgets/home/update_result_button.dart';
import 'package:konseki_app/widgets/home/virus_related_info.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = Provider.of<Auth>(context).name;
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "$name!",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .apply(color: Colors.blue),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    // print("new event page");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewEvent()));
                    Feedback.forTap(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InfoSection(),
            const SizedBox(
              height: 20,
            ),
            const VirusRelatedInfo(),
            const SizedBox(
              height: 10,
            ),
            const UpdateResultButton(),
          ],
        ),
      ),
    );
  }
}
