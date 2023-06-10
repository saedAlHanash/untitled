import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/plan_repository.dart';
import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_repository.dart';
import 'package:fitness_storm/Model/subscribed_plan.dart';
import 'package:fitness_storm/Model/trainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/plan.dart';

class TrainerHomeScreenController extends GetxController {
  final RxList<SubscribedPlan> continueTrainingPlans = <SubscribedPlan>[].obs;
  final RxList<Plan> trendingPlans = <Plan>[].obs;
  final RxList<Plan> featuredPlans = <Plan>[].obs;
  final RxList<Trainer> yourTrainer = <Trainer>[].obs;

  List<Plan> get trainerPlans => _trainerPlans;

  RxList<Plan> _trainerPlans = <Plan>[].obs;

  set trainerPlans(value) => _trainerPlans.value = value;

  final RxBool isLoading = false.obs;
  final Rx<TextEditingController> _searchEditingController =
      TextEditingController().obs;

  // final RxInt pageNumber = 1.obs;
  final TrainerPlanRepository _planRepository = TrainerPlanRepository();
  final TrainerTrainerRepository _trainerRepository =
      TrainerTrainerRepository();

  TextEditingController get searchController => _searchEditingController.value;

  set searchController(value) => _searchEditingController.value = value;

  @override
  Future<void> onInit() async {
    isLoading.value = true;

    await getTrainerPlans();
    // await _planRepository.gett();
    // continueTrainingPlans.value = await _planRepository.getContinueTrainingPlan();
    // trendingPlans.value = await _planRepository.getTrendingPlan({});
    // featuredPlans.value = await _planRepository.getFeaturedgPlan(1);
    // yourTrainer.value = await _trainerRepository.getYourTrainer(1);
    // if (!Get.isRegistered<TrainerPlansController>())
    //   Get.lazyPut(() => TrainerPlansController());
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getTrainerPlans() async {
    List<Plan> _plans = await _trainerRepository.getTrainerPlans();
    if (_plans.isNotEmpty) {
      _trainerPlans.addAll(_plans);
    }
    _trainerPlans.addAll([]);
  }
}
