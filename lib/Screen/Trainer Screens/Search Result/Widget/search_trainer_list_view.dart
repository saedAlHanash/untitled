import 'package:fitness_storm/Model/trainer.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/YourTrainer/Widget/trainer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../search_result_controller.dart';
import 'empty_search_result.dart';

class TrainerSearchTrainerListView
    extends GetWidget<TrainerSearchResultController> {
  const TrainerSearchTrainerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: controller.isLoadingTrainer
            ? const Center(child: CircularProgressIndicator.adaptive())
            : controller.trainers.isEmpty
                ? const TrainerEmptySearchResult()
                : SmartRefresher(
                    controller: controller.trainerRefreshController,
                    enablePullUp: true,
                    enablePullDown: false,
                    onLoading: controller.onLoadingTrainer,
                    footer: CustomFooter(
                      builder: (context, mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("pull_up_load".tr);
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = Text("load_failed!click_retry!".tr);
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("release_to_load_more".tr);
                        } else {
                          body = Text("no_more_data".tr);
                        }
                        return SizedBox(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    child: ListView.builder(
                      itemCount: controller.trainers.length,
                      itemBuilder: (context, index) {
                        Trainer trainer = controller.trainers[index];
                        return GestureDetector(
                          onTap: () => Get.toNamed(
                              AppRoutes.trainerTrainerOverviewScreen,
                              arguments: controller.trainers[index].id),
                          child: TrainerWidget(
                            trainerName: trainer.name!,
                            imageUrl: trainer.profilePic!,
                            numberOfPlans: trainer.numberOfPlans!,
                            numberOfPrivateHours: trainer.numberOfPrivateHours!,
                            numberOfSubscribers: trainer.numberOfSubscribers!,
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
