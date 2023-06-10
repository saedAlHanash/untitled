import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/Widget/trainee_text_field.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetailsBody extends GetWidget<TraineeProfileInfoController> {
  const ProfileDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: Get.width / 47,
              height: Get.height / 37,
              color: Get.theme.primaryColor,
              margin: EdgeInsets.only(right: Get.width / 17),
            ),
            Text('profile_details'.tr,
                style: TextStyle(color: Color(0xFF74569D), fontSize: 18))
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 12),
          child: Column(
            children: [
              TraineeTextField(
                text: 'full_name'.tr,
                controller: TextEditingController(
                    text: controller.userProfile.name.toString()),
                onChange: (String value) {
                  controller.userProfile.name = value;
                },
              ),
              TraineeTextField(
                text: 'email'.tr,
                controller: TextEditingController(
                    text: controller.userProfile.email.toString()),
                onChange: (String value) {
                  controller.userProfile.email = value;
                },
              ),
              TraineeTextField(
                text: 'Mobile'.tr,
                controller: TextEditingController(
                    text: controller.userProfile.mobile.toString()),
                onChange: (String value) {
                  controller.userProfile.mobile = value;
                },
              ),
              // const GenderCheckboxBody(),
              // const BirthdayDateBody()
            ],
          ),
        )
      ],
    );
  }
}
