
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerProfileOverviewBioCheck extends StatelessWidget {
  final String title;
  final String value;

  const TrainerProfileOverviewBioCheck(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: Get.width / 37.5),
          child: const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 30,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 7),
            ),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
