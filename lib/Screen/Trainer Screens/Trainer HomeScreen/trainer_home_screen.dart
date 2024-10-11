import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/trainer_home_screen_controller.dart';
import 'package:fitness_storm/core/widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/plans/ui/widget/item_plan.dart';
import '../../../generated/l10n.dart';

class TrainerHomeScreen extends GetView<TrainerHomeScreenController> {
  const TrainerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? SizedBox(
              height: Get.height,
              child: const Center(child: CircularProgressIndicator.adaptive()))
          : controller.trainerPlans.isEmpty
              ? NotFoundWidget(text: S.of(context).noPlansFound)
              : SingleChildScrollView(
                  child: Column(
                    children: controller.trainerPlans.map((plan) {
                      return ItemPlan(
                        plan: plan,
                      );
                    }).toList(),
                  ),
                ),
    );
  }
}

