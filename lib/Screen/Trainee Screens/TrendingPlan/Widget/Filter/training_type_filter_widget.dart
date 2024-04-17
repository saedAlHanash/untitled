import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'plan_filter_button.dart';

class TrainingTypeFilterWidget extends GetWidget<TrendingPlanController> {
  const TrainingTypeFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'TRAINING_TYPE'.tr,
            style: TextStyle(
                color: Color(0xFFA8A5A5),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Get.height / 81.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlanFilterButton(
                controller: controller.trainingTypesControllers[0],
                text: 'weightlifting'.tr,
                onTap: () => controller.toggleTrainingType(0),
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                controller: controller.trainingTypesControllers[1],
                text: 'bodyWeight'.tr,
                onTap: () => controller.toggleTrainingType(1),
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                controller: controller.trainingTypesControllers[2],
                text: 'hiit_training'.tr,
                onTap: () => controller.toggleTrainingType(2),
              ),
            ],
          ),
          SizedBox(height: Get.height / 81.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlanFilterButton(
                controller: controller.trainingTypesControllers[3],
                text: 'strength_training'.tr,
                onTap: () => controller.toggleTrainingType(3),
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                  controller: controller.trainingTypesControllers[4],
                  text: 'functional_training'.tr,
                  onTap: () => controller.toggleTrainingType(4)),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                controller: controller.trainingTypesControllers[5],
                text: 'mobility_training'.tr,
                onTap: () => controller.toggleTrainingType(5),
              ),
            ],
          ),
          SizedBox(height: Get.height / 81.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlanFilterButton(
                controller: controller.trainingTypesControllers[6],
                text: 'sports_training'.tr,
                onTap: () => controller.toggleTrainingType(6),
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                controller: controller.trainingTypesControllers[7],
                text: 'dynamic_training'.tr,
                onTap: () => controller.toggleTrainingType(7),
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                controller: controller.trainingTypesControllers[8],
                text: 'follo_along'.tr,
                onTap: () => controller.toggleTrainingType(8),
              ),
            ],
          ),
          SizedBox(height: Get.height / 81.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlanFilterButton(
                controller: controller.trainingTypesControllers[9],
                text: 'bodybuilding'.tr,
                onTap: () => controller.toggleTrainingType(9),
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                controller: controller.trainingTypesControllers[10],
                text: 'prenatal_training'.tr,
                onTap: () => controller.toggleTrainingType(10),
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                  controller: controller.trainingTypesControllers[11],
                  text: 'hands_free'.tr,
                  onTap: () => controller.toggleTrainingType(11)),
            ],
          ),
          SizedBox(height: Get.height / 81.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlanFilterButton(
                controller: controller.trainingTypesControllers[12],
                text: 'pilates'.tr,
                onTap: () => controller.toggleTrainingType(12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
