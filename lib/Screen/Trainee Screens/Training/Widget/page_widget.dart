 

import 'package:fitness_storm/Screen/Trainee%20Screens/Training/training_controller.dart';
import 'package:fitness_storm/Widgets/vimeo_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:vimeo_video_player/vimeo_video_player.dart';

import 'exercise_item.dart';

class PageWidget extends GetWidget<TrainingController> {
  final String videoId;

  // final List<Widget> setsAndRepsWidgets;
  final int sets;
  final List<int> reps;
  final List<bool> checks;

  const PageWidget({
    Key? key,
    required this.checks,
    required this.videoId,
    required this.sets,
    required this.reps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Stack(
        children: [
          Column(
            children: [
              //todo
              // new VimeoVideoPlayer(url: 'https://vimeo.com/${videoId}'),
                new VimeoPlayer(videoId: videoId),
              SizedBox(height: Get.height / 10),
              Column(children: buildItemsWidget()),
            ],
          ),
          Obx(
            () => Positioned(
              bottom: Get.height / 30,
              left: Get.width / 2.4,
              child: SizedBox(
                width: Get.width / 6,
                height: Get.height / 13,
                child: CircularProgressIndicator(
                  color: Get.theme.primaryColor,
                  value: controller.getPercentage(sets),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Get.height / 30,
            left: Get.width / 2.4,
            child: GestureDetector(
              onTap: () => controller.changePage(sets),
              child: CircleAvatar(
                radius: Get.width / 12,
                child: const Icon(Icons.check),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildItemsWidget() {
    List<Widget> exercises = [];
   //log('lengyjhhj ${reps.length}');
    // controller.currentChecks = List.filled(reps.length, false, growable: true);
    for (int i = 0; i < reps.length; i++) {
     //log('resps$reps  index $i');

      exercises.add(ExerciseItem(
        sets: i,
        reps: reps[i],
      ));
    }
    return exercises;
  }
}
