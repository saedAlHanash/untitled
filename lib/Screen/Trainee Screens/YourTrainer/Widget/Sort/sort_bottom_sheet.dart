import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Widgets/custom_button.dart';
import '../../your_trainer_controller.dart';
import 'sort_botton_widget.dart';

class SortBottomSheet extends GetWidget<YourTrainerController> {
  final Function onTap;

  const SortBottomSheet({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 2.5,
      padding: EdgeInsets.only(
          top: Get.height / 20.3,
          left: Get.width / 12.5,
          right: Get.width / 12.5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Obx(
        () => Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            'SORT_BY'.tr,
            style: const TextStyle(
                color: Color(0xFFA8A5A5),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Get.height / 81),
          Row(
            children: [
              SortBottonWidget(
                  controller: controller.sortFilterControllers[0],
                  text: controller.sortFilterTypes[0],
                  onTap: () => controller.toggleSortFilter(0)),
              SizedBox(width: Get.width / 37.5),
              SortBottonWidget(
                  controller: controller.sortFilterControllers[1],
                  text: controller.sortFilterTypes[1],
                  onTap: () => controller.toggleSortFilter(1))
            ],
          ),
          SizedBox(height: Get.height / 81),
          Row(
            children: [
              SortBottonWidget(
                  controller: controller.sortFilterControllers[2],
                  text: controller.sortFilterTypes[2],
                  onTap: () => controller.toggleSortFilter(2)),
              SizedBox(width: Get.width / 37.5),
              SortBottonWidget(
                  controller: controller.sortFilterControllers[3],
                  text: controller.sortFilterTypes[3],
                  onTap: () => controller.toggleSortFilter(3))
            ],
          ),
          SizedBox(height: Get.height / 81),
          Row(
            children: [
              SortBottonWidget(
                  controller: controller.sortFilterControllers[4],
                  text: controller.sortFilterTypes[4],
                  onTap: () => controller.toggleSortFilter(4)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onTapFunction: onTap,
                buttonColor: Get.theme.primaryColor,
                text: 'apply'.tr,
                textColor: Colors.white,
                fontSize: 13,
                width: Get.width / 3,
                padding: 0,
              ),
              CustomButton(
                onTapFunction: () => Get.back(),
                buttonColor: const Color(0xFFA0A0A0),
                text: 'cancel'.tr,
                textColor: Colors.white,
                fontSize: 13,
                width: Get.width / 3,
                padding: 0,
              )
            ],
          )
        ]),
      ),
    );
  }
}
