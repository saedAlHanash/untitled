import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/day_bar.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/trainer_bio.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/video_tail_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:fitness_storm/Widgets/read_more_text_widget.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../../Widgets/Exercise/day_widget.dart';
import '../../../Widgets/vimeo_player.dart';
import '../../../core/app/app_provider.dart';

class PlanOverviewScreen extends GetView<PlanOverviewController> {
  const PlanOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back()),
            title: Text(
                controller.isLoading ? '' : controller.planOverview.name,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        body: controller.isLoading
            ? MyStyle.loadingWidget()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VimeoPlayer(
                      videoId: controller.planOverview.introductionVideo,
                      onInitController: (videoController) {
                        controller.videoController = videoController;
                      },
                    ),
                    const VideoTailWidget(),
                    Column(
                      children: [
                        30.0.verticalSpace,
                        Text(
                          controller.planOverview.name,
                          style: const TextStyle(
                              color: Color(0xFF565C63), fontSize: 26),
                        ),
                        30.0.verticalSpace,
                        ReadMoreTextWidget(
                            text: controller.planOverview.description),
                        30.0.verticalSpace,
                        ListTile(
                          leading: CircleImageWidget(
                            url: controller.planOverview.trainer.image,
                            size: 70.0.r,
                          ),
                          title: DrawableText(
                              text: controller.planOverview.trainer.name),
                        ),
                        30.0.verticalSpace,
                        TrainerBio(controller.planOverview.trainer.bio),
                      ],
                    ),
                    const DayBar(),
                    SizedBox(height: Get.height / 25),
                    ListView.builder(
                      key: UniqueKey(),
                      controller: ScrollController(),
                      shrinkWrap: true,
                      itemCount: controller.planWorkouts.length,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          onTap: () {
                            controller.videoController?.pause();
                            controller.planWorkouts[i].name!.toLowerCase() !=
                                    'Rest day'.toLowerCase()
                                ? controller.startTraining(i)
                                : () {};
                          },
                          child: DayWidget(
                            key: controller.keys[i],
                            imageUrl: controller.planWorkouts[i].image!,
                            dayNumber: controller.planWorkouts[i].name!,
                            totalMinutes:
                                controller.planWorkouts[i].totalMinutes!,
                            exercises: controller.planWorkouts[i].exercises!,
                            type: controller.planWorkouts[i].type!,

                            // type:controller.planWorkouts[i].type!
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
        floatingActionButtonLocation: Platform.isIOS
            ? FloatingActionButtonLocation.centerDocked
            : FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (AppProvider.isTrainer)
            ? null
            : controller.isActivated ||
                    GetStorage().read('currentPlan') ==
                        controller.planOverview.name
                ? null
                : CustomButton(
                    onTapFunction: controller.subscribeToPlan,
                    buttonColor: Get.theme.primaryColor,
                    textColor: Colors.white,
                    padding: 0,
                    radius: 10,
                    fontSize: 16.0.sp,
                    height: Get.height / 15,
                    width: Get.width,
                    text: GetStorage().read('currentPlan') == null
                        ? 'subscribe'.tr
                        : 'start_within_plan'.tr),
      ),
    );
  }
}
