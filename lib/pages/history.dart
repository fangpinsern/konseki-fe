import 'package:flutter/material.dart';
import 'package:konseki_app/models/history_info.dart';
import 'package:konseki_app/widgets/history/event_list.dart';
import 'package:konseki_app/widgets/history/sections.dart';

class History extends StatefulWidget {
  final List<HistoryInfo> history;
  History(this.history);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.fromLTRB(
            23,
            MediaQuery.of(context).size.height * 0.1,
            23,
            0,
          ),
          margin: EdgeInsets.zero,
          child: const Text(
            "History",
            style: TextStyle(fontSize: 28),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.70,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var val = widget.history[index];
              return EventList(val.events, val.date);
            },
            itemCount: widget.history.length,
          ),
        )
      ],
    );
  }
}
