import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'trainer_profile_image_widget.dart';
import 'trainer_profile_info_widget.dart';

class TrainerProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String trainerName;

  const TrainerProfileHeader({
    super.key,
    required this.imageUrl,
    required this.trainerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width / 20, vertical: Get.height / 30),
      child: Row(
        children: [
          TrainerProfileImageWidget(imageUrl: Constants.imageUrl + imageUrl),
          TrainerProfileInfowidget(
            trainerName: trainerName,
          ),
        ],
      ),
    );
  }
}
