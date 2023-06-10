import 'package:fitness_storm/Model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'day_exercises_widget.dart';
import 'day_image.dart';

class DayWidget extends StatelessWidget {
  final String imageUrl;
  final String dayNumber;
  final int totalMinutes;
  final String type;
  final List<Exercises> exercises;

  const DayWidget({
    super.key,
    required this.imageUrl,
    required this.dayNumber,
    required this.totalMinutes,
    required this.exercises,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: exercises.length < 3 ? Get.height / 5 : Get.height / 3.2,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: Get.height / 162.4),
      color: const Color(0xFFF5F5F5),
      child: Center(
        child: Row(children: [
          DayImage(
            imageUrl: imageUrl,
            dayNumber: dayNumber,
            totalMinutes: totalMinutes,
            numberOfExercises: exercises.length,
          ),
          Expanded(child: DayExercisesWidget(exercises: exercises, type: type)),
        ]),
      ),
    );
  }
}
