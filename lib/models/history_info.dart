import 'package:flutter/material.dart';

class HistoryInfo {
  final DateTime date;
  final List<Event> events;

  HistoryInfo({
    required this.date,
    required this.events,
  });
}

class Event {
  final String title;
  final int pax;
  final DateTime date;
  final String link;
  Event(this.title, this.pax, this.date, this.link);
}
