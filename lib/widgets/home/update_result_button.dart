import 'package:flutter/material.dart';
import 'package:konseki_app/pages/update_result.dart';

class UpdateResultButton extends StatelessWidget {
  const UpdateResultButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tapped");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdateResult()));
        Feedback.forTap(context);
      },
      child: Card(
        color: const Color(0xFFE3F2FD),
        child: Container(
          width: 315,
          height: 120,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.code,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Update Result"),
            ],
          ),
        ),
      ),
    );
  }
}
