import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/current_exercise_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/exercises_listview.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/rest_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_controller.dart';
import 'package:fitness_storm/Widgets/vimeo_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../core/app/app_provider.dart';
import 'Widget/slide_widget.dart';

class UserTrainingScreen extends GetView<UserTrainingController> {
  const UserTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
      onWillPop: controller.complete ||  AppProvider.isTrainer
          ? null
          : () async {
        bool shouldNavigateBack = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context, false),
                      icon: Icon(
                        Icons.close,
                        color: Get.theme.primaryColor,
                      )),
                ],
              ),
              content: Text(
                'Did_you_finish_your_training'.tr,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.justify,
                style: const TextStyle(),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    try {
                      await controller.completeDay();
                      Navigator.pop(context);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                    } catch (e) {}

                    // Get.back();
                  },
                  child: Text(
                    'Done'.tr,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("i\'ll_come_back_later".tr),
                ),
              ],
            );
          },
        );

        return shouldNavigateBack;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(controller.nameWorkout)),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
          (controller.type == "Zumba" || controller.type == 'zumba')
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            (controller.type == "Zumba" || controller.type == 'zumba')
                ? Align(
              alignment: Alignment.center,
              child: controller.accessToken == ''
                  ? const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator.adaptive())
                  : Column(
                children: [
                  controller.progress < 1.0
                      ? Container(
                      padding: const EdgeInsets.all(10.0),
                      child: controller.progress < 1.0
                          ? LinearProgressIndicator(
                          value: controller.progress)
                          : const SizedBox.shrink())
                      : const SizedBox.shrink(),
                  SizedBox(
                    height:
                    MediaQuery.of(context).size.height * 0.283,
                    child: VimeoPlayer(
                        videoId: controller.currentExercise.video!),
                  ),
                ],
              ),
            )
                : SizedBox(
              height: MediaQuery.of(context).size.height * 0.283,
              child: Center(
                child: controller.accessToken == ''
                    ? const CircularProgressIndicator.adaptive()
                    : VimeoPlayer(
                    videoId: controller.currentExercise.video!,
                    isPrivet: true),
              ),
            ),
            (controller.type == "Zumba" || controller.type == 'zumba')
                ? const SizedBox.shrink()
                : CurrentExerciseWidget(
              color: Colors.white,
              title: controller.currentExercise.name!,
              isSecondsBased: controller.currentExercise.secondsBased!,
              reps: controller.currentExercise.repetitions!,
              set: controller.currentExercise.setCount!,
              notes: controller.currentExercise.notes!,
            ),
            (controller.type == "Zumba" || controller.type == 'zumba')
                ? const SizedBox.shrink()
                : ExerciseListView(),
            ( AppProvider.isTrainer)
                ? const SizedBox.shrink()
                : SizedBox(
              height: Get.height / 8,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: (controller.complete)
            ? Shimmer(
          color: Colors.white70,
          child: Container(
            color: Get.theme.colorScheme.secondary,
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'already_play'.tr,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              // textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
            ),
          ),
        )
            : controller.type == "Zumba" ||
            controller.type == 'zumba' ||
            ( AppProvider.isTrainer)
            ? const SizedBox.shrink()
            : Obx(
              () => controller.isLoading
              ? Container()
              : controller.isRest && controller.startTime > 0
              ? RestWidget(
            seconds: controller.type == "Loop Exercise"
                ? controller.startTime
                : 0,
            isBreak: controller.isBreak,
          )
              : Obx(
                () => SlidWidget(
              repetationNumber: controller.currentExercise
                  .repetitions![controller.currentSet - 1].count!,
              setNumber: controller.currentSet,
            ),
          ),
        ),
      ),
    ));
  }
}
