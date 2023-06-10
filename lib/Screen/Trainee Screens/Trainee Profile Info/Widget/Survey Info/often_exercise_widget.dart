import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../trainee_text_field.dart';

class OftenExerciseWidget extends GetWidget<TraineeProfileInfoController> {
  const OftenExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('you_often_exercise'.tr,
            style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 14)),
        TraineeTextField(
          text: '',
          controller: TextEditingController(
            text: controller.userProfile.fitnessSurvey != null
                ? controller.userProfile.fitnessSurvey!.dailyExercise.toString()
                : "0".toString(),
          ),
          suffixText: 'days/week'.tr,
          onChange: (String value) {
            controller.userProfile.fitnessSurvey!.dailyExercise =
                int.parse(value);
          },
        ),
        TraineeTextField(
          text: '',
          controller: TextEditingController(
              text: controller.userProfile.fitnessSurvey != null
                  ? controller.userProfile.fitnessSurvey!.weeklyExercise
                      .toString()
                  : "0"),
          suffixText: 'Hours/Day'.tr,
          onChange: (String value) {
            controller.userProfile.fitnessSurvey!.weeklyExercise =
                int.parse(value);
          },
        ),
      ],
    );
  }
}
