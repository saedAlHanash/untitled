import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/plans/data/response/plan_workout_response.dart';
import '../../features/training/data/response/exercises_response.dart';


class DayExercisesWidget extends StatelessWidget {

  final PlanWorkout item;
  const DayExercisesWidget({
    super.key,
    required this.item,

  });

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return AdaptiveScrollbar(
      controller: scrollController,
      width: 7,
      sliderDefaultColor: Get.theme.primaryColor,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: Get.height / 81.2),
        key: UniqueKey(),
        controller: scrollController,
        shrinkWrap: true,
        itemCount: item.exercises.length > 3 ? 3 : item.exercises.length,
        itemBuilder: (context, i) {
          return _buildExerciseInfo(
            item.exercises[i].name,
            item.exercises[i].setCount.toInt(),
            item.exercises[i].repetitions,
            item.exercises[i].secondBased,
            item.exercises.length > 3 && i == 2,
            item.type,
            item,
          );
        },
      ),
    );
  }

  Widget _buildExerciseInfo(
    String name,
    int sets,
    List<Repetition> reps,
    bool secondsBased,
    bool hasSeeMore,
    String type,
      PlanWorkout e,
  ) {
    return Column(
      crossAxisAlignment: type == 'Zumba' || type == 'zumba'
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFF565C63),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          // textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        ),
        type == 'Zumba' || type == 'zumba'
            ? const SizedBox.shrink()
            : Text(
                '$sets  ${'set_x'.tr} ${getRepsString(
                  reps,
                  secondsBased,
                )}',
                style: TextStyle(color: Get.theme.colorScheme.secondary, fontSize: 12),
                // textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
              ),
        type == 'Zumba' || type == 'zumba'
            ? const SizedBox.shrink()
            : Divider(
                endIndent: Get.width / 3,
                color: const Color(0xFFA0A0A0),
              ),
        hasSeeMore
            ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'see_more'.tr,
                  style: TextStyle(
                    color: Get.theme.colorScheme.secondary,
                    fontSize: 12,
                  ),
                  // textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                ),
                SizedBox(width: Get.width / 50),
                Icon(Icons.arrow_circle_right,
                    size: 12, color: Get.theme.colorScheme.secondary),
              ])
            : const SizedBox.shrink()
      ],
    );
  }

  String getRepsString(
    List<Repetition> reps,
    bool isSecondsBased,
  ) {
    String repsText = '';
    for (int i = 0; i < reps.length; i++) {
      if (i == reps.length - 1) {
        repsText += '${reps[i].count}';
      } else {
        repsText += '${reps[i].count} - ';
      }
    }

    if (isSecondsBased) {
      repsText += 'Sec'.tr;
    } else {
      repsText += 'Rep'.tr;
    }

    return repsText;
  }
}
