import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/Widget/trainer_plans_button.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/Widget/trainer_profile_body.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/Widget/trainer_profile_header.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/Widget/trainer_profile_info_button.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/trainer_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerProfileScreen extends GetView<TrainerProfileController> {
  const TrainerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        child: controller.isLoading
            ? Center(
                child: CircularProgressIndicator(color: Get.theme.primaryColor))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    TrainerProfileHeader(),
                    TrainerPlansButton(),
                    TrainerProfileBody(),
                    TrainerProfileInfoButton(),
                  ],
                ),
              ),
      ),
    );
  }
}
