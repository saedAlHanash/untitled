import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../features/plans/data/response/plan_workout_response.dart';
import '../../generated/l10n.dart';
import 'day_exercises_widget.dart';

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
        color: item.isFinish
            ? AppColorManager.secondColor.withOpacity(0.1)
            : AppColorManager.cardColor,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Row(
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
                child: DayExercisesWidget(item: item),
              ),
            ],
          ),
          if (item.isFinish)
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                margin: EdgeInsets.all(7.0).r,
                padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0).r,
                decoration: BoxDecoration(
                  color: AppColorManager.mainColor,
                  borderRadius: BorderRadius.circular(12.0.r),
                ),
                child: DrawableText(
                  text: S.of(context).finish,
                  color: AppColorManager.whit,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
