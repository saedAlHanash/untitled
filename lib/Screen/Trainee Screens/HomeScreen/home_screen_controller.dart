import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Data/Repositories/trainer_repository.dart';
import 'package:fitness_storm/Model/subscribed_plan.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/models/plan_model.dart';
import '../../../core/util/shared_preferences.dart';

class HomeScreenController extends GetxController {
  final RxList<SubscribedPlan> continueTrainingPlans = <SubscribedPlan>[].obs;
  final RxList<Plan> featuredPlans = <Plan>[].obs;
  final RxBool isLoading = false.obs;

  // final RxInt pageNumber = 1.obs;
  final PlanRepository planRepository = PlanRepository();

  final TrainerRepository trainerRepository = TrainerRepository();
  final RxList<Plan> trendingPlans = <Plan>[].obs;
  final RxList<TrainerModel> yourTrainer = <TrainerModel>[].obs;

  final Rx<TextEditingController> _searchEditingController =
      TextEditingController().obs;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    await fillContinueTrainingPlans();

    if (continueTrainingPlans.isNotEmpty) {
      AppSharedPreference.serCurrentPlanId(
          continueTrainingPlans.value.first.id.toString());
    }
    // Get.back();
    trendingPlans.value = await planRepository.getTrendingPlan({});
    featuredPlans.value = await planRepository.getFeaturedgPlan(1);
    yourTrainer.value = await trainerRepository.getYourTrainer(1);
    isLoading.value = false;
    super.onInit();
  }

  Future<void> reInitial() async {
    isLoading.value = true;
    await fillContinueTrainingPlans();
    if (continueTrainingPlans.isNotEmpty) {
      AppSharedPreference.serCurrentPlanId(
          continueTrainingPlans.value.first.id.toString());
    }
    // Get.back();
    trendingPlans.value = await planRepository.getTrendingPlan({});
    featuredPlans.value = await planRepository.getFeaturedgPlan(1);
    yourTrainer.value = await trainerRepository.getYourTrainer(1);
    isLoading.value = false;
  }

  TextEditingController get searchController => _searchEditingController.value;

  set searchController(value) => _searchEditingController.value = value;

  Future<List<SubscribedPlan>> getContinueTrainingPlan() =>
      planRepository.getContinueTrainingPlan();

  Future<void> fillContinueTrainingPlans() async {
    continueTrainingPlans.value =
        await planRepository.getContinueTrainingPlan();
  }
}
