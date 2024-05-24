import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Overview/trainer_overview_controller.dart';
import 'package:fitness_storm/features/trainer/ui/widget/trainer_bio_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../features/bookmarked/ui/widget/see_all_list_item.dart';
import 'Widget/ProfileHader/trainer_profile_header.dart';

class TrainerTrainerOverviewScreen extends GetView<TrainerTrainerOverviewController> {
  const TrainerTrainerOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    TrainerProfileHeader(
                      imageUrl: controller.trainer.image!,
                      trainer: controller.trainer,
                    ),
                    TrainerBioWidget(trainer: controller.trainer),
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 0.5,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                'plans_by_this_trainer'.tr,
                                style: TextStyle(
                                    color: Get.theme.primaryColor, fontSize: 20),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 0.5,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.trainerPlans.length,
                      itemBuilder: (context, index) {
                        return SeeAllListItem(
                          plan: controller.trainerPlans[index],
                        );
                      },
                    )
                  ],
                ),
              ),
      ),
    );
  }

  /*
  Obx(
      () => Scaffold(
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    controller.isVisible = false;
                  } else if (direction == ScrollDirection.forward) {
                    controller.isVisible = true;
                  }
                  return true;
                },
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: Get.height,
                          child: ImageMultiType(url:
                             controller.trainer.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: Get.width / 3,
                          right: Get.width / 3,
                          child: controller.isVisible
                              ? Icon(
                                  FontAwesomeIcons.chevronUp,
                                  size: Get.width / 10,
                                )
                              : Container(),
                        )
                      ],
                    ),
                    SizedBox(height: Get.height / 20),
                    Padding(
                      padding: EdgeInsets.all(Get.width / 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: Get.height / 50),
                          buildReadMoreText(text: controller.trainer.bio!),
                          SizedBox(height: Get.height / 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(FontAwesomeIcons.calendarAlt),
                              SizedBox(width: Get.width / 50),
                              Text(controller.trainer.numberOfPlans!),
                              SizedBox(width: Get.width / 50),
                              const Text(
                                'Plan',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    VimoePlayer(videoId: controller.trainer.introductionVideo!),
                    const TrainerPlans()
                  ],
                ),
              ),
      ),
    );

  */

  Widget buildReadMoreText({required String text}) {
    return ReadMoreText(
      text,
      style: const TextStyle(color: Colors.white),
      trimMode: TrimMode.Line,
      trimLines: 2,
      lessStyle: TextStyle(color: Theme.of(Get.context!).primaryColor),
      moreStyle: TextStyle(color: Theme.of(Get.context!).primaryColor),
    );
  }
}
