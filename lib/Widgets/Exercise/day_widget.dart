import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/plans/data/response/plan_workout_response.dart';
import '../../features/training/data/response/exercises_response.dart';
import 'day_exercises_widget.dart';
import 'day_image.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
    super.key,
    required this.item,
  });
  final PlanWorkout item;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: item.exercises.length < 3 ? Get.height / 5 : Get.height / 3.2,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: Get.height / 162.4),
      color: const Color(0xFFF5F5F5),
      child: Center(
        child: Row(children: [
          DayImage(
            item: item,
          ),
          Expanded(
            child: DayExercisesWidget(
              item: item,
            ),
          ),
        ]),
      ),
    );
  }
}
