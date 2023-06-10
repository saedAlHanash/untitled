import 'package:fitness_storm/Screen/Trainee%20Screens/FilterResultPage/Widget/filter_result_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterResultPage/filter_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterResultScreen extends GetView<FilterResultController> {
  const FilterResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.plansOverviews.length,
                itemBuilder: (context, index) {
                  return FilterResult(
                      imageUrl: controller.plansOverviews[index].image!,
                      planName: controller.plansOverviews[index].name!,
                      trainerName:
                          controller.plansOverviews[index].trainer!.name!);
                }),
      ),
    );
  }
}
