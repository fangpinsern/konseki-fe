import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konseki_app/models/history_info.dart';
import 'package:konseki_app/pages/qr_page.dart';
import 'package:konseki_app/providers/event.dart';
import 'package:konseki_app/widgets/utils/top_navbar.dart';
import 'package:provider/provider.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({Key? key}) : super(key: key);

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  final titleController = TextEditingController();

  Future<QRInfo> _submit() async {
    var res = await Provider.of<Events>(context, listen: false)
        .createEvent(titleController.text);
    return QRInfo(res.title, res.link, res.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          // check if api success
          // use the return value
          var result = await _submit();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QRPage(
                groupName: result.title,
                groupLink: result.link,
              ),
            ),
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Create",
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopNavBar(
                header: "New Event",
                haveBackNav: true,
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Event Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 3,
                        ))),
                controller: titleController,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Date",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(
                      DateTime.now().toLocal(),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
