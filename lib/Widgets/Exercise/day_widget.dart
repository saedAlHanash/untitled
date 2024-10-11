import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../features/plans/data/response/plan_workout_response.dart';
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
      width: Get.width,
      margin: EdgeInsets.all(15.0).r,
      decoration: BoxDecoration(
        color: AppColorManager.cardColor,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: Row(
          children: [
            SizedBox(
              height: 0.3.sh,
              width: 0.3.sw,
              child: ImageMultiType(
                url: item.image,
              ),
            ),
            10.0.horizontalSpace,
            Expanded(
              child: DayExercisesWidget(
                item: item,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
