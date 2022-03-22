import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:konseki_app/pages/update_result.dart';

class UpdateResultButton extends StatelessWidget {
  const UpdateResultButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UpdateResult()));
        Feedback.forTap(context);
      },
      child: Card(
        color: const Color(0xFFE3F2FD),
        child: Container(
          width: double.infinity,
          // height: 120,
          constraints: const BoxConstraints(
            minHeight: 110,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/testkit-icon.svg",
                height: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Update result",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
