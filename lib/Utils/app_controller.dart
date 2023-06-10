import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:fitness_storm/Model/training_type.dart';
import 'package:get/get.dart';

import 'Constants/enums.dart';

class AppController extends GetxController {
  Rx<ThemeColor> theme = ThemeColor.light.obs;
  List<TrainingType> trainingTypes = [];
  PlanRepository planRepository = PlanRepository();

  getAllTrainingTypes() async {
    trainingTypes = await planRepository.getAllTrainingType();
  }
}
