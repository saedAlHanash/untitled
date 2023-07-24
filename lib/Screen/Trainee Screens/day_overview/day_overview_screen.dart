import 'package:fitness_storm/Screen/Trainee%20Screens/day_overview/day_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/vimeo_player.dart';

class DayOverviewScreen extends GetView<DayOverviewController> {
  const DayOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo
                  // new VimeoVideoPlayer(url: 'https://vimeo.com/${controller.videoPreview}'),
                  new VimeoPlayer(videoId: controller.videoPreview),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.workoutName,
                          style:
                              Get.textTheme.bodyLarge!.copyWith(fontSize: 25),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: Get.height / 50),
                        Text('${controller.totalMinut.toString()} ' + 'min'.tr),
                        SizedBox(height: Get.height / 30),
                        Text('${controller.exercises.length} ' + 'exercise'.tr),
                        Padding(
                          padding: EdgeInsets.only(bottom: Get.height / 20),
                          child: SingleChildScrollView(
                            child: Column(
                                // children: _buildExercise(controller.exercises),
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: !controller.isActivated
                  ? Container()
                  : Container(
                      width: Get.width / 1.5,
                      height: Get.height / 20,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: controller.startTraining,
                          child: Text('start_workout'.tr)),
                    )),
        ],
      ),
    );
  }
}
