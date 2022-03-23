import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  final String header;
  bool haveBackNav;
  TopNavBar({Key? key, required this.header, this.haveBackNav = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        MediaQuery.of(context).size.height * 0.07,
        0,
        0,
      ),
      child: Row(
        children: [
          if (haveBackNav)
            IconButton(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
          Text(
            header,
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    );
  }
}
