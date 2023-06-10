import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widget/trainer_image_widget.dart';
import '../Widget/trainer_info_widget.dart';

class TrainerWidget extends StatelessWidget {
  final String imageUrl;
  final String trainerName;
  final String numberOfPlans;
  final String numberOfSubscribers;
  final String numberOfPrivateHours;

  const TrainerWidget({
    super.key,
    required this.imageUrl,
    required this.trainerName,
    required this.numberOfPlans,
    required this.numberOfSubscribers,
    required this.numberOfPrivateHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 4.8,
      width: Get.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: Get.height / 32.48),
      margin: EdgeInsets.only(bottom: Get.height / 162.4),
      child: Row(
        children: [
          TrainerImageWidget(imageUrl: Constants.imageUrl + imageUrl),
          TrainerInfoWidget(
            trainerName: trainerName,
            numberOfPlans: numberOfPlans,
            numberofSubscribers: numberOfSubscribers,
            numberOfPrivateHours: numberOfPrivateHours,
          )
        ],
      ),
    );
  }
}
