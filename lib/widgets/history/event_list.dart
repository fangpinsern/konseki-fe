import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konseki_app/models/history_info.dart';

class EventList extends StatelessWidget {
  final List<Event> events;
  final DateTime date;
  EventList(this.events, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
            ))),
            child: Text(
              DateFormat("EEEE, d MMM").format(date),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          ...events.map((val) {
            return Container(
              margin: EdgeInsets.all(0),
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    DateFormat("jm").format(val.date),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      val.title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${val.pax.toString()} pax",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ]),
            );
          }).toList(),
        ],
      ),
    );
  }
}
