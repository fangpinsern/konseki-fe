import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konseki_app/models/history_info.dart';
import 'package:konseki_app/pages/qr_page.dart';
import 'package:konseki_app/providers/event.dart';
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
        .CreateEvent(titleController.text);
    return QRInfo(res.title, res.link, res.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "New Event",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  )
                ],
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
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(
                      DateTime.now().toLocal(),
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  // check if api success
                  // use the return value
                  var result = await _submit();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QRPage(
                        groupName: result.title,
                        eventId: result.link,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 325,
                  height: 48,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Create",
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
