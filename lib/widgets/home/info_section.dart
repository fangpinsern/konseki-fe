import 'package:flutter/material.dart';
import 'package:konseki_app/models/alert_info.dart';

class InfoSection extends StatefulWidget {
  AlertInfo alertMessage;
  InfoSection(this.alertMessage);

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xfff0f0f0),
      child: Container(
        width: 315,
        height: 120,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: widget.alertMessage.isImportant
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "IMPORTANT",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.alertMessage.message,
                    style: TextStyle(
                      fontSize: 14,
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
