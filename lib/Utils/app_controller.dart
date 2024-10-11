import 'package:fitness_storm/Data/Repositories/plan_repository.dart';
import 'package:get/get.dart';

import '../core/models/plan_model.dart';
import '../core/strings/enum_manager.dart';


class AppController extends GetxController {
  Rx<ThemeColor> theme = ThemeColor.light.obs;
  List<TrainingType> trainingTypes = [];
  PlanRepository planRepository = PlanRepository();

}
