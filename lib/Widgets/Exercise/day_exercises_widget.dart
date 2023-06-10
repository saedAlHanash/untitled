import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:fitness_storm/Model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/repetition.dart';

class DayExercisesWidget extends StatelessWidget {
  final List<Exercises> exercises;
  final String type;

  const DayExercisesWidget({
    super.key,
    required this.exercises,
    required this.type,
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
        itemCount: exercises.length > 3 ? 3 : exercises.length,
        itemBuilder: (context, index) {
          return _buildExerciseInfo(
            exercises[index].name!,
            exercises[index].setCount!,
            exercises[index].repetitions!,
            exercises[index].secondsBased!,
            exercises.length > 3 && index == 2,
            type,
          );
        },
      ),
    );
  }

  Widget _buildExerciseInfo(
    String name,
    int sets,
    List<Repetitions> reps,
    bool secondsBased,
    bool hasSeeMore,
    String type,
  ) {
    bool isEnglish = Get.locale!.languageCode == 'en';
    return Column(
      crossAxisAlignment: type == 'Zumba' || type == 'zumba'
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style:  const TextStyle(
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
                style: TextStyle(
                    color: Get.theme.colorScheme.secondary, fontSize: 12),
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
    List<Repetitions> reps,
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
