import 'package:fitness_storm/Model/trainer.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Widget/filter_row.dart';
import 'Widget/trainer_widget.dart';
import 'your_trainer_controller.dart';

class YourTrainersScreen extends GetView<YourTrainerController> {
  const YourTrainersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text('Our Trainer'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        body: Column(
          children: [
            FilterRow(
              selectedIndex: controller.selectedIndex,
              aboutTrainer: true,
            ),
            Expanded(child: _buildYourTrainerList(controller.trainers)),
          ],
        ),
      ),
    );
  }

  Widget _buildYourTrainerList(List<Trainer> trainers) {
    return controller.isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : SmartRefresher(
            controller: controller.refreshController.value,
            enablePullUp: true,
            enablePullDown: false,
            onLoading: controller.onLoading,
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
              shrinkWrap: true,
              itemCount: controller.trainers.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.traienrOverview,
                      arguments: controller.trainers[i].id),
                  child: TrainerWidget(
                    imageUrl: controller.trainers[i].profilePic!,
                    numberOfPlans: controller.trainers[i].numberOfPlans!,
                    trainerName: controller.trainers[i].name!,
                    numberOfSubscribers:
                        controller.trainers[i].numberOfSubscribers!,
                    numberOfPrivateHours:
                        controller.trainers[i].numberOfPrivateHours!,
                  ),
                );
              },
            ),
          );
  }
}
