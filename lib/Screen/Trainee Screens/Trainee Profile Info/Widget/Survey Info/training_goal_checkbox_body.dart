import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingGoalCheckboxBody extends GetWidget<TraineeProfileInfoController> {
  const TrainingGoalCheckboxBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('your_training_goal'.tr + ' :',
                style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 16)),
            Column(
              children: [
                Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                          unselectedWidgetColor: const Color(0xFFA0A0A0)),
                      child: Checkbox(
                        value: controller.isLoseWeight,
                        onChanged: (value) {
                          if (value!) {
                            controller.trainingGoal = 'Lose weight';
                          } else {
                            controller.trainingGoal = '';
                          }
                          controller.isLoseWeight = value;
                          controller.isBuildMuscle = false;
                          controller.isStayFit = false;
                          controller.userProfile.fitnessSurvey!.trainingGoal =
                              controller.trainingGoal;
                        },
                        activeColor: Get.theme.colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        checkColor: Get.theme.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'lose_weight'.tr,
                      style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                    )
                  ],
                ),
                Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                          unselectedWidgetColor: const Color(0xFFA0A0A0)),
                      child: Checkbox(
                        value: controller.isBuildMuscle,
                        onChanged: (value) {
                          if (value!) {
                            controller.trainingGoal = 'Build muscle';
                          } else {
                            controller.trainingGoal = '';
                          }
                          controller.isLoseWeight = false;
                          controller.isBuildMuscle = value;
                          controller.isStayFit = false;
                          controller.userProfile.fitnessSurvey!.trainingGoal =
                              controller.trainingGoal;
                        },
                        activeColor: Get.theme.colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        checkColor: Get.theme.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'build_muscle'.tr,
                      style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                    )
                  ],
                ),
                Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                          unselectedWidgetColor: const Color(0xFFA0A0A0)),
                      child: Checkbox(
                        value: controller.isStayFit,
                        onChanged: (value) {
                          if (value!) {
                            controller.trainingGoal = 'Stay fit';
                          } else {
                            controller.trainingGoal = '';
                          }
                          controller.isLoseWeight = false;
                          controller.isBuildMuscle = false;
                          controller.isStayFit = value;
                        },
                        activeColor: Get.theme.colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        checkColor: Get.theme.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'stay_fit'.tr,
                      style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
