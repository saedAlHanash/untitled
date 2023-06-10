import 'package:fitness_storm/Model/repetition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingExerciseWidget extends StatelessWidget {
  final String title;
  final int sets;
  final List<Repetitions> reps;
  final bool isSecondsBased;
  final bool isFinished;
  final bool isPlaying;

  const TrainingExerciseWidget({
    super.key,
    required this.title,
    required this.isFinished,
    required this.isPlaying,
    required this.sets,
    required this.reps,
    required this.isSecondsBased,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5, vertical: 15),
      margin: EdgeInsets.only(bottom: Get.height / 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildExerciseHeader(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Color(0xFF565C63),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$sets  ' +
                    'set_x'.tr +
                    ' ${getRepsString(
                      reps,
                      isSecondsBased,
                    )}',
                style: TextStyle(
                    color: Get.theme.colorScheme.secondary, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
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
      repsText += ' Sec';
    } else {
      repsText += ' Rep';
    }

    return repsText;
  }

  Widget buildExerciseHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width / 22,
          height: Get.width / 22,
          child: Checkbox(
              value: isFinished,
              onChanged: (_) {},
              shape: const CircleBorder(),
              fillColor:
                  MaterialStatePropertyAll(Get.theme.colorScheme.secondary)),
        ),
        SizedBox(width: Get.width / 60),
        isPlaying
            ? Container(
                width: Get.width / 22,
                height: Get.width / 22,
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Get.theme.primaryColor),
                child: Center(
                  child: Icon(
                    Icons.play_arrow_sharp,
                    color: Colors.white,
                    size: Get.width / 22,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
