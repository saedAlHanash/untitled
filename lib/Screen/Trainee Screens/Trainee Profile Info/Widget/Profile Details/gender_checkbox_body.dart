import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderCheckboxBody extends GetWidget<TraineeProfileInfoController> {
  const GenderCheckboxBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Text('gender'.tr,
              style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 16)),
          SizedBox(width: 15),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: controller.isMale,
                        onChanged: (value) {
                          if (value!) {
                            controller.userGender = 'male';
                          } else {
                            controller.userGender = '';
                          }
                          controller.isMale = value;
                          controller.isFemale = false;
                        },
                        activeColor: Get.theme.colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        checkColor: Get.theme.colorScheme.secondary,
                      ),
                      Text(
                        'male'.tr,
                        style:
                            TextStyle(color: Color(0xFF565C63), fontSize: 12),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                          value: controller.isFemale,
                          onChanged: (value) {
                            if (value!) {
                              controller.userGender = 'home';
                            } else {
                              controller.userGender = '';
                            }
                            controller.isFemale = value;
                            controller.isMale = false;
                          },
                          activeColor: Get.theme.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          checkColor: Get.theme.colorScheme.secondary,
                        ),
                      Text(
                        'female'.tr,
                        style:
                            TextStyle(color: Color(0xFF565C63), fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
