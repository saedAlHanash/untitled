import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/current_exercise_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/exercises_listview.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/rest_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_controller.dart';
import 'package:fitness_storm/Widgets/vimeo_player.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../core/app/app_provider.dart';
import '../../../generated/l10n.dart';
import 'Widget/slide_widget.dart';
import 'change_video_cubit/change_video_cubit.dart';

class UserTrainingScreen extends GetView<UserTrainingController> {
  const UserTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: controller.complete || AppProvider.isTrainer
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
                          child: Text(S.of(context).iLlComeBackLater),
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
                  mainAxisAlignment: controller.isZumba
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<ChangeVideoCubit, ChangeVideoInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return controller.isZumba
                            ? Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    controller.progress < 1.0
                                        ? Container(
                                            padding: const EdgeInsets.all(10.0),
                                            child: controller.progress < 1.0
                                                ? LinearProgressIndicator(
                                                    value: controller.progress)
                                                : 0.0.verticalSpace)
                                        : 0.0.verticalSpace,
                                    VimeoPlayer1(
                                      key: UniqueKey(),
                                      videoId:
                                          controller.currentExercise.video!,
                                    ),
                                  ],
                                ),
                              )
                            : VimeoPlayer(
                                videoId: controller.currentExercise.video!,
                                onInitController: (videoController) {},
                              );
                      },
                    ),
                    controller.isZumba
                        ? 0.0.verticalSpace
                        : CurrentExerciseWidget(
                            color: Colors.white,
                            title: controller.currentExercise.name!,
                            isSecondsBased:
                                controller.currentExercise.secondsBased!,
                            reps: controller.currentExercise.repetitions!,
                            set: controller.currentExercise.setCount!,
                            notes: controller.currentExercise.notes!,
                          ),
                    controller.isZumba ? 0.0.verticalSpace : ExerciseListView(),
                    (AppProvider.isTrainer)
                        ? 0.0.verticalSpace
                        : SizedBox(
                            height: Get.height / 8,
                          ),
                  ],
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
              : controller.isZumba || (AppProvider.isTrainer)
                  ? 0.0.verticalSpace
                  : Obx (
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
                                    repetationNumber: controller
                                        .currentExercise
                                        .repetitions![controller.currentSet - 1]
                                        .count!,
                                    setNumber: controller.currentSet,
                                  ),
                                ),
                    ),
        ),
      );
    });
  }
}
