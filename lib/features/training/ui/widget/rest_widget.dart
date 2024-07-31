import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RestWidget extends GetWidget<UserTrainingController> {
  final num seconds;
  final bool isBreak;

  const RestWidget({required this.seconds, required this.isBreak, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: Get.height / 8,
        child: LinearPercentIndicator(
          percent: controller.getPercentage(),
          lineHeight: double.infinity,
          backgroundColor: !isBreak
              ? Get.theme.colorScheme.secondary
              : Get.theme.primaryColor,
          progressColor: isBreak
              ? const Color(0xFF9F86C1)
              : Get.theme.colorScheme.secondary.withOpacity(0.4),
          padding: const EdgeInsets.all(0),
          center: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              const SizedBox(),
              !controller.isBreak
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "let's_go".tr,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          'you_can_do_it_this_set'.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'great_job!'.tr,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          'take_a_break'.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.type == "Loop Exercise"
                              ? 'before_the_next_exercise'.tr
                              : 'before_the_next_set'.tr,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
              Text(
                formatTimePerSeconds(controller.startTime),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTimePerSeconds(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  String formatTimePerMinutes(int minutes) {
    return '${(Duration(minutes: minutes))}'.split('.')[0].padLeft(8, '0');
  }
}
