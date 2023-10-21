import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:fitness_storm/helperClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutLocationCheckboxBody
    extends GetWidget<TraineeProfileInfoController> {
  const WorkoutLocationCheckboxBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('${'you_workout_in'.tr} :',
              style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 14)),
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Row(
                  children: [
                    Checkbox(
                      value: controller.isGym,
                      onChanged: (value) {
                        if (value!) {
                          controller.userWorkoutLocation = 'gym';
                          HelperClass.workoutLocation = 'gym';
                        } else {
                          controller.userWorkoutLocation = '';
                        }
                        controller.isGym = value;
                        controller.isHome = false;
                        // controller.userProfile.fitnessSurvey.
                      },
                      activeColor: Get.theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      checkColor: Get.theme.colorScheme.secondary,
                    ),
                    Text(
                      'gym'.tr,
                      style: TextStyle(color: Color(0xFF565C63), fontSize: 11),
                    )
                  ],
                ),
              ),
              // SizedBox(width: 2),
              SizedBox(
                width: 90,
                child: Row(
                  children: [
                    Checkbox(
                      value: controller.isHome,
                      onChanged: (value) {
                        if (value!) {
                          controller.userWorkoutLocation = 'home';
                          HelperClass.workoutLocation = 'home';
                        } else {
                          controller.userWorkoutLocation = '';
                        }
                        controller.isHome = value;
                        controller.isGym = false;
                      },
                      activeColor: Get.theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      checkColor: Get.theme.colorScheme.secondary,
                    ),
                    Text(
                      'home'.tr,
                      style: TextStyle(color: Color(0xFF565C63), fontSize: 11),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
