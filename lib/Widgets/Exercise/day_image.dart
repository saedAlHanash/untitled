import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../features/plans/data/response/plan_workout_response.dart';

class DayImage extends StatelessWidget {
  final PlanWorkout item;

  const DayImage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Get.width / 18,
        right: Get.width / 18,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 13.0),
        child: _buildExerciseImage(),
      ),
    );
  }

  Widget _buildExerciseImage() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            height: item.exercises.length < 3 ? Get.height / 6 : Get.height / 3.7,
            width: Get.width / 2.9,
            child: ImageMultiType(
              url: item.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  String formatTimePerSeconds(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  String formatTimePerMinutes(num minutes) {
    return '${(Duration(minutes: minutes.toInt()))}'.split('.')[0].padLeft(8, '0');
  }
}
