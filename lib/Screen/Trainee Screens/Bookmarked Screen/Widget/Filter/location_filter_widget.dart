import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../bookmarked_screen_controller.dart';
import 'plan_filter_button.dart';

class LocationFilterWidget extends GetWidget<BookmarkedScreenController> {
  const LocationFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'LOCATION'.tr,
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
                text: 'home'.tr,
                controller: controller.homeController,
                onTap: controller.toggleHome,
              ),
              const Expanded(child: SizedBox()),
              PlanFilterButton(
                text: 'gym'.tr,
                controller: controller.gymController,
                onTap: controller.toggleGym,
              ),
            ],
          ),
          SizedBox(height: Get.height / 20.3),
        ],
      ),
    );
  }
}
