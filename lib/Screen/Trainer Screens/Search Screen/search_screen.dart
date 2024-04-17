import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Screen/Widget/term_and_condition_widget.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Screen/search_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widget/search_bar_widget.dart';

class TrainerSearchScreen extends GetView<TrainerSearchScreenController> {
  const TrainerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Get.theme.primaryColor,
            Get.theme.colorScheme.secondary,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: Get.height / 1.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox.shrink()),
              Expanded(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: Get.width / 2.9,
                        child: Image.asset(
                          "asset/Images/white_logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const TrainerSearchBarWidget()
                  ],
                ),
              ),
              const TrainerTermAndConditionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
