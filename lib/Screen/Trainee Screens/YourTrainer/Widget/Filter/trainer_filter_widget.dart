import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../your_trainer_controller.dart';
import 'plan_filter_button.dart';

class TrainerFilterWidget extends GetWidget<YourTrainerController> {
  const TrainerFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'trainer'.tr,
            style: const TextStyle(
                color: Color(0xFFA8A5A5),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Get.height / 81),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlanFilterButton(
                text: 'Public'.tr,
                controller: controller.publicController,
                onTap: controller.togglePublic,
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                text: 'Private'.tr,
                controller: controller.privateController,
                onTap: controller.togglePrivate,
              ),
            ],
          ),
          SizedBox(height: Get.height / 20.3),
        ],
      ),
    );
  }
}
