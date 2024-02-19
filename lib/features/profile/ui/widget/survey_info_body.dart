import 'package:fitness_storm/features/profile/ui/widget/height_weight_widget.dart';
import 'package:fitness_storm/features/profile/ui/widget/often_exercise_widget.dart';
import 'package:fitness_storm/features/profile/ui/widget/training_goal_checkbox_body.dart';
import 'package:fitness_storm/features/profile/ui/widget/training_level_checkbox_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'workout_location_checkbox_body.dart';

class SurveyInfoBody extends StatelessWidget {
  const SurveyInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height / 14.6),
        Row(
          children: [
            Container(
              width: Get.width / 47,
              height: Get.height / 37,
              color: Get.theme.primaryColor,
              margin: EdgeInsets.only(right: Get.width / 17),
            ),
            Text('survey_info'.tr,
                style: TextStyle(color: Color(0xFF74569D), fontSize: 18))
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 12),
          child: Column(
            children: const [
              HeightWeightWidget(),
              OftenExerciseWidget(),
              WorkoutLocationCheckboxBody(),
              TrainingLevelCheckboxBody(),
              TrainingGoalCheckboxBody()
            ],
          ),
        )
      ],
    );
  }
}
