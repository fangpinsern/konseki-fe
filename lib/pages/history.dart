import 'package:flutter/material.dart';
import 'package:konseki_app/models/history_info.dart';
import 'package:konseki_app/providers/event.dart';
import 'package:konseki_app/widgets/history/event_list.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    try {
      Provider.of<Events>(context, listen: false).GetEvents();
    } catch (err) {
      // AlertDialog()
    }
    super.initState();
  }

  Future<void> _refreshEvents(BuildContext context) async {
    await Provider.of<Events>(context, listen: false).GetEvents();
  }

  @override
  Widget build(BuildContext context) {
    var his = Provider.of<Events>(context).historyInfo;
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
        RefreshIndicator(
          onRefresh: () => _refreshEvents(context),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.70,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                var val = his[index];
                return EventList(val.events, val.date);
              },
              itemCount: his.length,
            ),
          ),
        )
      ],
    );
  }
}
