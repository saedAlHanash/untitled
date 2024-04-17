// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Plans/trainer_plans_controller.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Plans/trainer_plans_controller.dart';
import 'package:get/instance_manager.dart';

import '../Trainer HomeScreen/trainer_home_screen_controller.dart';

class TrainerPlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerPlansController());
    Get.lazyPut(() => TrainerHomeScreenController());
  }
}
