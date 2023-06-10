import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/trainer_profile_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerPlansButton extends GetView<TrainerProfileController> {
  const TrainerPlansButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onTapFunction: () => controller.onMyPlansButtonPressed(),
          text: 'my_plans'.tr,
          buttonColor: Get.theme.primaryColor,
          width: Get.width,
          textColor: Colors.white,
          radius: 15,
          fontSize: 18,
          height: Get.height / 16.24,
          padding: 0,
        ),
        SizedBox(height: Get.height / 40.6)
      ],
    );
  }
}
