import 'dart:io';

import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/day_bar.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/trainer_bio.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/video_tail_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_controller.dart';
import 'package:fitness_storm/Utils/storage_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:fitness_storm/Widgets/read_more_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/Exercise/day_widget.dart';
import '../../../Widgets/custom_chip.dart';
import '../../../Widgets/vimeo_player.dart';
import 'Widget/trainer_profile.dart';

class PlanOverviewScreen extends GetView<PlanOverviewController> {
  const PlanOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back()),
            title: Text(controller.isLoading ? '' : controller.planOverview.name!,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VimeoPlayer(
                      videoId: controller.planOverview.introductionVideo!,
                      onInitController: (videoController) {
                        controller.videoController = videoController;
                      },
                    ),
                    const VideoTailWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            controller.planOverview.name!,
                            style:
                                const TextStyle(color: Color(0xFF565C63), fontSize: 26),
                          ),
                          Text(
                            controller.planOverview.trainer!.name!,
                            style: TextStyle(
                                color: Get.theme.colorScheme.secondary, fontSize: 14),
                          ),
                          SizedBox(
                            width: Get.width,
                            height: Get.height / 20,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    children: controller.planOverview.trainingLocation!
                                        .map((e) => CustomChip(text: e.type!))
                                        .toList()),
                                Row(
                                    children: controller.planOverview.trainingLevel!
                                        .map((e) => CustomChip(text: e.type!))
                                        .toList()),
                                Row(
                                    children: controller.planOverview.trainingType!
                                        .map((e) => CustomChip(text: e.type!))
                                        .toList()),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          ReadMoreTextWidget(text: controller.planOverview.description!),
                          const SizedBox(height: 30),
                          TrainerProfile(controller.planOverview.trainer!.name!,
                              controller.planOverview.trainer!.profilePic!),
                          const SizedBox(height: 30),
                          TrainerBio(controller.planOverview.trainer!.bio!),
                        ],
                      ),
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
                            totalMinutes: controller.planWorkouts[i].totalMinutes!,
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
        floatingActionButton: (StorageController().userType == 'trainer')
            ? const SizedBox.shrink()
            : controller.isActivated
                ? Container()
                : CustomButton(
                    onTapFunction: controller.onSubscribePlan,
                    buttonColor: Get.theme.primaryColor,
                    textColor: Colors.white,
                    padding: 0,
                    radius: 10,
                    height: Get.height / 15,
                    width: Get.width,
                    text: 'subscribe'.tr),
      ),
    );
  }
}
