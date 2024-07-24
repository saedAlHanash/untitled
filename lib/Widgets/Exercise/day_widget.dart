import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/plans/data/response/plan_workout_response.dart';
import 'day_exercises_widget.dart';
import 'day_image.dart';

class DayWidget extends StatefulWidget {
  final String imageUrl;
  final String dayNumber;
  final int totalMinutes;
  final String type;
  final List<Exercise> exercises;

  const DayWidget({
    super.key,
    required this.imageUrl,
    required this.dayNumber,
    required this.totalMinutes,
    required this.exercises,
    required this.type,
  });

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.exercises.length < 3 ? Get.height / 5 : Get.height / 3.2,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: Get.height / 162.4),
      color: const Color(0xFFF5F5F5),
      child: Center(
        child: Row(children: [
          DayImage(
            imageUrl: widget.imageUrl,
            dayNumber: widget.dayNumber,
            totalMinutes: widget.totalMinutes,
            numberOfExercises: widget.exercises.length,
          ),
          Expanded(child: DayExercisesWidget(exercises: widget.exercises, type: widget.type)),
        ]),
      ),
    );
  }
}
