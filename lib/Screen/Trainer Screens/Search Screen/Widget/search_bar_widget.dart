import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Screen/search_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TrainerSearchBarWidget extends GetWidget<TrainerSearchScreenController> {
  const TrainerSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 21,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
      margin: EdgeInsets.only(top: Get.height / 40.6),
      child: TextField(
        controller: controller.serachController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          focusColor: Colors.white,
          hintText: "What_are_you_searching_for?".tr,
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFD1D1D1)),
          suffixIcon: GestureDetector(
            onTap: controller.onSearch,
            child: Container(
              width: Get.width / 12.5,
              margin: EdgeInsets.all(Get.height / 200),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(500))),
              child: SvgPicture.asset(
                'asset/Images/search_bar.svg',
                color: Colors.white,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
      ),
    );
  }
}
