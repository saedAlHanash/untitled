import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlidWidget extends GetWidget<UserTrainingController> {
  final int setNumber;
  final int repetationNumber;

  const SlidWidget({
    required this.setNumber,
    required this.repetationNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Get.locale?.languageCode == 'en';
    return Obx(
      () => Container(
        height: Get.height / 8,
        alignment: Alignment.bottomCenter,
        color: Get.theme.colorScheme.secondary,
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (_) => controller
              .startRestTimer(controller.currentExercise.secondsBased!),
          //controller.isRest = true,
          direction: isEnglish
              ? DismissDirection.startToEnd
              : DismissDirection.endToStart,
          child: Container(
            color: Get.theme.colorScheme.secondary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      '${'set'.tr} ${controller.currentSet}',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'repeat_this_exercise'.tr,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          _getRepeatText(),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                !controller.currentExercise.secondsBased!
                    ? Text('slide_to_start_the_next_set'.tr,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white))
                    : Text('slide_to_start_the_timer_for_this_set'.tr,
                        maxLines: 3,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRepeatText() {
    String reps = controller
        .currentExercise.repetitions![controller.currentSet - 1].count!
        .toString();
    if (controller.currentExercise.secondsBased!) {
      if (int.parse(reps) > 3 && int.parse(reps) < 9) {
        reps += " ${'seconds'.tr}";
      } else {
        reps += 'second'.tr;
      }
    } else {
      if (int.parse(reps) > 3 && int.parse(reps) < 9) {
        reps += " ${'times'.tr}";
      } else {
        reps += 'time'.tr;
      }
    }
    return reps;
  }
}
