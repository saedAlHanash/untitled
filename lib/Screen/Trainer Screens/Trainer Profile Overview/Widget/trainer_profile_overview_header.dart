import 'package:fitness_storm/Screen/Trainee%20Screens/Trainer%20Overview/Widget/ProfileHader/trainer_profile_image_widget.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Profile%20Overview/Widget/trainer_profile_overview_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerProfileOverviewHeader extends StatelessWidget {
  final String imageUrl;
  final String trainerName;

  const TrainerProfileOverviewHeader(
      {super.key, required this.imageUrl, required this.trainerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 3.75,
      padding: EdgeInsets.symmetric(
          horizontal: Get.width / 18.75, vertical: Get.height / 27.5),
      child: Row(
        children: [
          TrainerProfileImageWidget(imageUrl: imageUrl),
          TrainerProfileOverviewInfo(trainerName: trainerName),
        ],
      ),
    );
  }
}
