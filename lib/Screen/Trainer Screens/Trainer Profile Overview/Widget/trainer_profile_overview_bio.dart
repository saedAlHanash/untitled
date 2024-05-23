import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Profile%20Overview/Widget/trainer_profile_overview_bio_check.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerProfileOverviewBio extends StatelessWidget {
  const TrainerProfileOverviewBio({super.key, required this.trainer});

  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.height / 20.3,
          color: Get.theme.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
          child: Container(),
        ),
        Container(
          color: const Color(0xFF9F86C1),
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: Get.height / 27),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TrainerProfileOverviewBioCheck(
                        title: 'WORKOUT_PLANS'.tr,
                        value: trainer.numberOfPlans.toString()),
                    TrainerProfileOverviewBioCheck(
                        title: 'SUBSCRIBERS_cap'.tr,
                        value: trainer.numberOfSubscribers.toString()),
                    TrainerProfileOverviewBioCheck(
                        title: 'private_hours'.tr,
                        value: '+${trainer.numberOfPrivateHours}'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: Get.height / 27,
                  left: Get.width / 16,
                  right: Get.width / 16,
                ),
                child: Center(
                  child: Text(
                    trainer.bio,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
