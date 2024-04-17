import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerInfoWidget extends StatelessWidget {
  final String trainerName;
  final String numberOfPlans;
  final String numberofSubscribers;
  final String numberOfPrivateHours;

  const TrainerInfoWidget({
    super.key,
    required this.trainerName,
    required this.numberOfPlans,
    required this.numberofSubscribers,
    required this.numberOfPrivateHours,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width / 1.6,
          child: Text(
            trainerName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xFF565C63),
            ),
          ),
        ),
        SizedBox(height: Get.height / 100.66),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$numberOfPlans ' + 'plans'.tr,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF565C63),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 37.5),
              child: const Text('•',
                  style: TextStyle(color: Color(0xFF565C63), fontSize: 24)),
            ),
            Text(
              '$numberofSubscribers  ' + 'subscriber'.tr,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF565C63),
              ),
            ),
          ],
        ),
        Text(
          '+$numberOfPrivateHours ' + 'private_hours'.tr,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF565C63),
          ),
        ),
      ],
    );
  }
}
