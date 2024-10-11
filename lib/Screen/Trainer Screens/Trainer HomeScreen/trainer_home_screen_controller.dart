import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_repository.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/plan_model.dart';

class TrainerHomeScreenController extends GetxController {

  final RxList<Plan> trendingPlans = <Plan>[].obs;
  final RxList<Plan> featuredPlans = <Plan>[].obs;
  final RxList<TrainerModel> yourTrainer = <TrainerModel>[].obs;

  List<Plan> get trainerPlans => _trainerPlans;

  final RxList<Plan> _trainerPlans = <Plan>[].obs;

  set trainerPlans(value) => _trainerPlans.value = value;

  final RxBool isLoading = false.obs;
  final Rx<TextEditingController> _searchEditingController =
      TextEditingController().obs;


  final TrainerTrainerRepository _trainerRepository =
      TrainerTrainerRepository();

  TextEditingController get searchController => _searchEditingController.value;

  set searchController(value) => _searchEditingController.value = value;

  @override
  Future<void> onInit() async {
    isLoading.value = true;

    await getTrainerPlans();

    isLoading.value = false;
    super.onInit();
  }

  Future<void> getTrainerPlans() async {
    final plans = await _trainerRepository.getTrainerPlans();

    if (plans.isNotEmpty) {
      _trainerPlans.addAll(plans);
    }
    _trainerPlans.addAll([]);
  }
}
