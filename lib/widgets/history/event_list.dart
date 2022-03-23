import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:konseki_app/models/history_info.dart';
import 'package:konseki_app/pages/qr_page.dart';

class EventList extends StatelessWidget {
  final List<Event> events;
  final DateTime date;
  EventList(this.events, this.date, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
            ))),
            child: Text(
              DateFormat("EEEE, d MMM").format(date),
              style: Theme.of(context).textTheme.headline3!.apply(
                    color: Colors.blue,
                  ),
            ),
          ),
          ...events.map((val) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: Row(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9 * 0.2,
                  // padding: const EdgeInsets.all(10),
                  child: Text(
                    DateFormat("jm").format(val.date),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9 * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        val.title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        "${val.pax.toString()} pax",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9 * 0.1,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QRPage(
                                groupName: val.title,
                                groupLink: val.link,
                              )));
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/qr-icon.svg",
                      color: Colors.blue,
                    ),
                  ),
                )
              ]),
            );
          }).toList(),
        ],
      ),
    );
  }
}
