import 'package:flutter/material.dart';

class VirusRelatedInfo extends StatelessWidget {
  const VirusRelatedInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const covidSymptoms = [
      "Fever",
      "Cough",
      "Runny Nose",
      "Sore Throat",
      "Loss of taste or smell"
    ];
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Covid-19 Related Information",
            style: Theme.of(context).textTheme.headline3,
          ),
          const Divider(
            color: Color.fromARGB(255, 240, 240, 240),
            thickness: 1,
          ),
          Text(
            "  Common symptoms",
            style: Theme.of(context).textTheme.headline3,
          ),
          ...covidSymptoms.map((val) {
            return Container(
              child: Text(
                "    - $val",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2,
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Remember to test regularly and social distance where possible!",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .apply(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
