
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Widgets/trainer_profile_image.dart';

class TrainerProfile extends StatelessWidget {
  final String trianerName;
  final String trainerImageUrl;

  const TrainerProfile(this.trianerName, this.trainerImageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: Get.width,
          height: 100,
          color: Colors.white,
        ),
        Container(
          width: Get.width / 1.2,
          height: Get.height / 15,
          padding: EdgeInsets.only(left: Get.width / 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Get.theme.primaryColor.withOpacity(0.05)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'about_the_coach'.tr,
                style: const TextStyle(color: Color(0xFF565C63), fontSize: 12),
              ),
              FittedBox(
                child: Text(
                  trianerName,
                  style: TextStyle(color: Get.theme.primaryColor),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Get.width / 30,
          child: TrainerProfileImage(
            trainerImageUrl: trainerImageUrl,
          ),
        )
      ],
    );
  }
}
