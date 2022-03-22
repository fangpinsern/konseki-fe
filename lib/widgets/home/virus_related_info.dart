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
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Covid-19 Related Information",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 240, 240, 240),
            thickness: 1,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "  Common symptoms",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          ...covidSymptoms.map((val) {
            return Container(
              child: Text("    - $val"),
              margin: EdgeInsets.symmetric(
                vertical: 2,
              ),
            );
          }),
          SizedBox(
            height: 10,
          ),
          Text(
            "Remember to test regularly and social distance where possible!",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
