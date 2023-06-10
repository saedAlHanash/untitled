import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'trainer_profile_image_widget.dart';
import 'trainer_profile_info_widget.dart';

class TrainerProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String trainerName;

  const TrainerProfileHeader(
      {super.key, required this.imageUrl, required this.trainerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 3.75,
      padding: EdgeInsets.symmetric(
          horizontal: Get.width / 18.75, vertical: Get.height / 27.5),
      child: Row(
        children: [
          TrainerProfileImageWidget(imageUrl: Constants.imageUrl + imageUrl),
          const SizedBox(width: 30),
          TrainerProfileInfowidget(trainerName: trainerName),
        ],
      ),
    );
  }
}
