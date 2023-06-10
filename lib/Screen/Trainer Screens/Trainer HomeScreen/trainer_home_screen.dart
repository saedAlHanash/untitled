import 'dart:developer';

import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/HomeSreenWidget/search_result.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/trainer_home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Routes/app_pages.dart';
import '../../../Widgets/plan_time_freqency.dart';
import '../../../Widgets/see_all_list_item.dart';

class TrainerHomeScreen extends GetView<TrainerHomeScreenController> {
  const TrainerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? SizedBox(
              height: Get.height,
              child: const Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(
                children: controller.trainerPlans.map((plan) {
                  return SeeAllListItem(
                    plan: plan,
                    isPressed: () {},
                    index: -1,
                    subTitle: PlanTimeFrequency(
                      totalWeeks: plan.totalWeeks!,
                      workoutFrequency: plan.workoutFrequency,
                      color: Colors.grey,
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    PlanRepository planRepository = PlanRepository();
    return FutureBuilder(
      future: planRepository.searchPlans(query),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          log(snapshot.data.toString());
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              // return Text(snapshot.data[index].image);
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.planOverview,
                    arguments: snapshot.data[index].id),
                child: SearchResult(
                    imageUrl: snapshot.data[index].image,
                    planName: snapshot.data[index].name,
                    trainerName: snapshot.data[index].trainer.name),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    log('qqqqqqqqqqqqqqqqqqqq');
    log(query.toString());
    return Container();
  }
}
