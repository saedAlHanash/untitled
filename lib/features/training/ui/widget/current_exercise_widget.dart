import 'package:fitness_storm/Model/repetition.dart';
import 'package:fitness_storm/features/training/data/response/exercises_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentExerciseWidget extends StatelessWidget {
  final Color color;
  final String title;
  final num set;
  final List<Repetition> reps;
  final bool isSecondsBased;
  final String notes;

  const   CurrentExerciseWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.reps,
      required this.isSecondsBased,
      required this.notes,
      required this.set});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: EdgeInsets.symmetric(
          horizontal: Get.width / 12.5, vertical: Get.height / 40.5),
      margin: EdgeInsets.only(bottom: Get.height / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: notes == ""
                ? Text(
                    title,
                    style: const TextStyle(
                        color: Color(0xFF565C63),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                : Text(
                    '$title\n$notes',
                    style: const TextStyle(
                        color: Color(0xFF565C63),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
          ),
          const SizedBox(),
          Expanded(
            child: Text(
              '$set ${'set_x'.tr}${getRepsString()}',
              style: TextStyle(
                  color: Get.theme.colorScheme.secondary, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  String getRepsString() {
    String repsText = '';
    for (int i = 0; i < reps.length; i++) {
      if (i == reps.length - 1) {
        repsText += '${reps[i].count}';
      } else {
        repsText += '${reps[i].count} - ';
      }
    }

    if (isSecondsBased) {
      repsText += ' Sec';
    } else {
      repsText += ' Rep';
    }

    return repsText;
  }
}
