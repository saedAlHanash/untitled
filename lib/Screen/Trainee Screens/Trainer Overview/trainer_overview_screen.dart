import 'package:fitness_storm/Screen/Trainee%20Screens/Trainer%20Overview/Widget/ProfileBio/trainer_bio_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Trainer%20Overview/trainer_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../Widgets/plan_time_freqency.dart';
import '../../../Widgets/see_all_list_item.dart';
import 'Widget/ProfileHader/trainer_profile_header.dart';

class TrainerOverviewScreen extends GetView<TrainerOverviewController> {
  int x = -1;

  TrainerOverviewScreen({super.key});

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
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    TrainerProfileHeader(
                      imageUrl: controller.trainer.profilePic!,
                      trainer: controller.trainer,
                    ),
                    TrainerBioWidget(
                      trainerBio: controller.trainer.bio!,
                      privateSessionPrice:
                          controller.trainer.privateSessionPrice!.toString(),
                      numberOfPlans: controller.trainer.numberOfPlans!,
                      numberOfPrivateHours:
                          controller.trainer.numberOfPrivateHours!,
                      numberOfSubscribers:
                          controller.trainer.numberOfSubscribers!,
                    ),
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
                                    color: Get.theme.primaryColor,
                                    fontSize: 15),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: controller.trainerPlans.map((e) {
                        x++;
                        return SeeAllListItem(
                          plan: e,
                          isPressed: controller.addPlanToFavorite,
                          index: x,
                          subTitle: PlanTimeFrequency(
                            totalWeeks: e.totalWeeks!,
                            workoutFrequency: e.workoutFrequency,
                            color: Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }

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
