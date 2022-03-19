import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:konseki_app/models/alert_info.dart';
import 'package:konseki_app/models/history_info.dart';
import 'dart:convert';

class Events with ChangeNotifier {
  // Future<Void> CreateEvent(Event event) {

  // }

  List<HistoryInfo> historyInfo = [];
  AlertInfo alertMessage = AlertInfo(
      message: "No news is good news",
      date: DateTime.now(),
      isImportant: false);
  String token;

  final String _backendURL = '10.0.2.2:8080';

  Events(this.token, this.historyInfo);
// class Event {
//   final String title;
//   final int pax;
//   final DateTime date;
//   final String link;
//   Event(this.title, this.pax, this.date, this.link);
// }
  Future<QRInfo> CreateEvent(String eventName) async {
    var url = Uri.http(_backendURL, "/event/create");
    try {
      var response = await http.post(url,
          body: json.encode({
            "name": eventName,
          }),
          headers: {"Authorization": "Bearer $token"});

      final responseData = json.decode(response.body);
      print(responseData);
      final newEvent = QRInfo(responseData['name'], responseData['id']);
      return newEvent;
    } catch (err) {
      throw err;
    }
  }

  Future<JoinEventResponse> JoinEvent(String eventId) async {
    var url = Uri.http(_backendURL, "/event/join");
    try {
      var response = await http.post(url,
          body: json.encode({
            "id": eventId,
          }),
          headers: {"Authorization": "Bearer $token"});

      final responseData = json.decode(response.body);
      print(responseData);
      final sucessfullyJoin = JoinEventResponse(responseData['event_name'],
          responseData['id'], responseData['is_success']);

      return sucessfullyJoin;
    } catch (err) {
      throw err;
    }
  }

  Future<void> GetEvents() async {
    var url = Uri.http(_backendURL, "/event/all");
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

      helper.sort((a, b) {
        final aDate = a.date;
        final bDate = b.date;
        return bDate.compareTo(aDate);
      });

      historyInfo = helper;

      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<bool> UpdateStatus(bool isPositive, DateTime date) async {
    if (!isPositive) {
      return true;
    }
    var url = Uri.http(_backendURL, "/infection/update");
    try {
      var response = await http.post(url,
          body: json.encode({
            "date": (date.millisecondsSinceEpoch / 1000).ceil(),
          }),
          headers: {"Authorization": "Bearer $token"});

      final responseData = json.decode(response.body);
      print(responseData);

      final sucessfullyJoin = responseData['is_success'];

      return sucessfullyJoin;
    } catch (err) {
      throw err;
    }
  }

  Future<void> GetMessage() async {
    var url = Uri.http(_backendURL, "/messages/all");
    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final responseData = json.decode(response.body);
      print(responseData); // will have messages

      final messages = responseData['messages'];

      if (messages == null) {
        return;
      }

      // sort the events

      final firstMessage = messages[0];
      final newAlert = AlertInfo(
        message: firstMessage['message'],
        date: DateTime.fromMillisecondsSinceEpoch(
            firstMessage['created_date'] * 1000),
        isImportant: firstMessage['is_important'],
      );

      alertMessage = newAlert;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
