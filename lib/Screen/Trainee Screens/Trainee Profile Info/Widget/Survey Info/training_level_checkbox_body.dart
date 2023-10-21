import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingLevelCheckboxBody
    extends GetWidget<TraineeProfileInfoController> {
  const TrainingLevelCheckboxBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your_training_level'.tr + ' :',
                style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 14)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: controller.isBeginner,
                      onChanged: (value) {
                        if (value!) {
                          controller.trainingLevel = 'Beginner';
                        } else {
                          controller.trainingLevel = '';
                        }
                        controller.isBeginner = value;
                        controller.isIntermediate = false;
                        controller.isProfessional = false;
                        controller.userProfile.fitnessSurvey!
                            .trainingLevelId = controller.trainingLevel;
                      },
                      activeColor: Get.theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      checkColor: Get.theme.colorScheme.secondary,
                    ),
                    Expanded(
                      child: Text(
                        'beginner'.tr,
                        style:
                            TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: controller.isIntermediate,
                      onChanged: (value) {
                        if (value!) {
                          controller.trainingLevel = 'Intermediate';
                        } else {
                          controller.trainingLevel = '';
                        }
                        controller.isBeginner = false;
                        controller.isIntermediate = value;
                        controller.isProfessional = false;
                        controller.userProfile.fitnessSurvey!
                            .trainingLevelId = controller.trainingLevel;
                      },
                      activeColor: Get.theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      checkColor: Get.theme.colorScheme.secondary,
                    ),
                    Expanded(
                      child: Text(
                        'intermediate'.tr,
                        style:
                            TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: controller.isProfessional,
                      onChanged: (value) {
                        if (value!) {
                          controller.trainingLevel = 'Advanced';
                        } else {
                          controller.trainingLevel = '';
                        }
                        controller.isBeginner = false;
                        controller.isIntermediate = false;
                        controller.isProfessional = value;
                        controller.userProfile.fitnessSurvey!
                            .trainingLevelId = controller.trainingLevel;
                      },
                      activeColor: Get.theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      checkColor: Get.theme.colorScheme.secondary,
                    ),
                    Expanded(
                      child: Text(
                        'professional'.tr,
                        style:
                            TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
