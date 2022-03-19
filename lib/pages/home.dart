import 'package:flutter/material.dart';
import 'package:konseki_app/models/alert_info.dart';
import 'package:konseki_app/pages/new_event.dart';
import 'package:konseki_app/providers/auth.dart';
import 'package:konseki_app/providers/event.dart';
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
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      "$name!",
                      style: const TextStyle(
                        fontSize: 35,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    print("new event page");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewEvent()));
                    Feedback.forTap(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                  )),
            ],
          ),
          const SizedBox(
            height: 38,
          ),
          InfoSection(),
          const SizedBox(
            height: 20,
          ),
          VirusRelatedInfo(),
          SizedBox(
            height: 30,
          ),
          UpdateResultButton(),
        ],
      ),
    );
  }
}
