import 'package:flutter/material.dart';
import 'package:konseki_app/models/alert_info.dart';
import 'package:konseki_app/providers/event.dart';
import 'package:provider/provider.dart';

class InfoSection extends StatefulWidget {
  // AlertInfo alertMessage;
  InfoSection();

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  @override
  void initState() {
    // TODO: implement initState
    try {
      Provider.of<Events>(context, listen: false).GetMessage();
    } catch (err) {
      // AlertDialog()
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alertMessage = Provider.of<Events>(context).alertMessage;
    return Card(
      color: Color(0xfff0f0f0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 17.5,
          horizontal: 15,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: alertMessage.isImportant
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "IMPORTANT",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    alertMessage.message,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Steve from (3 Mar) Morning run has tested positive.",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.inbox,
                    size: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Don’t worry! No news is good news :)"),
                ],
              ),
      ),
    );
  }
}
