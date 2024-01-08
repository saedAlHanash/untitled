import 'package:fitness_storm/Screen/Trainee%20Screens/Workout%20Screen/workout_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/plan.dart';
import '../../../Utils/Routes/app_pages.dart';
import '../../../Widgets/custom_button.dart';
import '../HomeScreen/home_screen_controller.dart';
import 'Widget/day_bar.dart';

class WorkoutScreen extends GetView<WorkoutScreenController> {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : controller.workouts.isNotEmpty
              ? Column(children: [
                  const DayBar(),
                  // SizedBox(height: Get.height / 25),
                  // ScrollablePositionedList.builder(
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(children: controller.workoutWidgets),
                  )
                      //  ListView.builder(
                      //   key: UniqueKey(),
                      //   // itemScrollController: controller.scrollController,
                      //   controller: ScrollController(),
                      //   shrinkWrap: true,
                      //   itemCount: controller.workouts.length,
                      //   itemBuilder: (context, index) {
                      //     return GestureDetector(
                      //       onTap: () => controller.startTraining(index),
                      //       child: DayWidget(
                      //         key: controller.keys[index],
                      //         imageUrl: controller.workouts[index].image!,
                      //         dayNumber: (index + 1).toString(),
                      //         totalMinutes: controller.workouts[index].totalMinutes!,
                      //         exercises: controller.workouts[index].exercises!,
                      //       ),
                      //     );
                      //   },
                      // ),
                      ),
                ])
              : Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('no_current_plan'.tr),
                    CustomButton(
                      onTapFunction: () {
                        Get.toNamed(
                          AppRoutes.featuredPlamScreen,
                          arguments: Get.find<HomeScreenController>().featuredPlans,
                        );
                      },
                      textColor: Colors.white,
                      fontSize: 16,
                      text: 'choose_a_plan'.tr,
                    )
                  ],
                )),
    );
  }
}
