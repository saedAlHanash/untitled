import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/HomeSreenWidget/ContinueTraining/continue_training_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/HomeSreenWidget/search_result.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/refresh_home_plan_cubit/refresh_home_plan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Utils/Routes/app_pages.dart';
import 'HomeSreenWidget/FeaturedPlanWidget/featured_plan_widget.dart';
import 'HomeSreenWidget/TrendingPlanWidget/trending_plan_widget.dart';
import 'HomeSreenWidget/yourTainerWidget/your_trainer_widget.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? SizedBox(
              height: Get.height,
              child: const Center(child: CircularProgressIndicator.adaptive()))
          : RefreshIndicator(
              onRefresh: () async {
                controller.isLoading.value = true;
                await controller.fillContinueTrainingPlans();
                GetStorage getStorage = GetStorage();
                if (controller.continueTrainingPlans.isNotEmpty) {
                  await getStorage.write('currentPlan',
                      controller.continueTrainingPlans.value[0].name);
                }
                Get.back();
                controller.trendingPlans.value =
                    await controller.planRepository.getTrendingPlan({});
                controller.featuredPlans.value =
                    await controller.planRepository.getFeaturedgPlan(1);
                controller.yourTrainer.value =
                    await controller.trainerRepository.getYourTrainer(1);
                controller.isLoading.value = false;
              },
              child: BlocListener<RefreshHomePlanCubit, RefreshHomePlanState>(
                listener: (context, state) {
                  controller.reInitial();
                },
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      ContinueTrainingWidget(),
                      TrendingPlanWidget(),
                      FeaturedPlanWidget(),
                      YourTrainersWidget(),
                    ],
                  ),
                ),
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
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              // return Text(snapshot.data[index].image);
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.planOverview,
                      arguments: snapshot.data[index].id);
                },
                child: SearchResult(
                    imageUrl: snapshot.data[index].image,
                    planName: snapshot.data[index].name,
                    trainerName: snapshot.data[index].user.name),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //log('qqqqqqqqqqqqqqqqqqqq');
    //log(query.toString());
    return Container();
  }
}
