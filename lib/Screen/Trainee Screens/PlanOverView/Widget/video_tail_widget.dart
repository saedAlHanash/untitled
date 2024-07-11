import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoTailWidget extends GetWidget<PlanOverviewController> {
  const VideoTailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Get.theme.colorScheme.secondary,
      padding: EdgeInsets.all(Get.height / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${controller.planOverview.workoutFrequency} ${'days/week'.tr}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '${controller.planOverview.totalWeeks}${controller.planOverview.totalWeeks > 1 &&
                        controller.planOverview.totalWeeks < 10
                    ? ' ${'weeks'.tr}'
                    : ' ${'week'.tr}'}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
