import 'package:flutter/material.dart';
import 'package:konseki_app/providers/event.dart';
import 'package:provider/provider.dart';

class InfoSection extends StatefulWidget {
  // AlertInfo alertMessage;
  InfoSection({Key? key}) : super(key: key);

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  @override
  void initState() {
    try {
      Provider.of<Events>(context, listen: false).getMessage();
    } catch (err) {
      // AlertDialog()
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alertMessage = Provider.of<Events>(context).alertMessage;
    return Card(
      elevation: 0,
      color: const Color(0xfff0f0f0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 17.5,
          horizontal: 15,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: alertMessage.isImportant
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "IMPORTANT",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    alertMessage.message,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Steve from (3 Mar) Morning run has tested positive.",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inbox,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Don’t worry! No news is good news :)",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
      ),
    );
  }
}
