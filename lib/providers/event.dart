import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:konseki_app/models/history_info.dart';
import 'dart:convert';

class Events with ChangeNotifier {
  // Future<Void> CreateEvent(Event event) {

  // }

  List<HistoryInfo> historyInfo = [];
  String token;

  Events(this.token, this.historyInfo);
  Future<void> GetEvents() async {
    var url = Uri.http('10.0.2.2:8080', "/event/all");
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final responseData = json.decode(response.body);
      print(responseData); // will have events

      final events = responseData['events'];

      // sort the events

      final Map<String, List<Event>> helperMap = {};

      for (var i in events) {
        final DateTime date1 =
            DateTime.fromMillisecondsSinceEpoch(i['date'] * 1000);
        final Event newEvent =
            Event(i['name'], i['attended'].length, date1, i['id']);

        final String dateString = DateFormat("yMMMd").format(date1);

        if (helperMap[dateString] == null) {
          helperMap[dateString] = [newEvent];
        } else {
          helperMap[dateString]!.add(newEvent);
        }
      }

      final List<HistoryInfo> helper = [];

      helperMap.forEach((key, value) {
        final info = HistoryInfo(date: value[0].date, events: value);
        helper.add(info);
      });

      historyInfo = helper;

      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
