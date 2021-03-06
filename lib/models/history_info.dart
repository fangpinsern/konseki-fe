class HistoryInfo {
  final DateTime date;
  final List<Event> events;

  HistoryInfo({
    required this.date,
    required this.events,
  }) {
    events.sort((a, b) {
      final aDate = a.date;
      final bDate = b.date;
      return bDate.compareTo(aDate);
    });
  }
}

class Event {
  final String title;
  final int pax;
  final DateTime date;
  final String link;
  Event(this.title, this.pax, this.date, this.link);
}

class QRInfo {
  final String title;
  final String id;
  final String link;
  QRInfo(this.title, this.link, this.id);
}

class JoinEventResponse {
  final String title;
  final String id;
  final bool isSuccess;
  final String creatorName;
  JoinEventResponse(this.title, this.id, this.isSuccess, this.creatorName);
}
