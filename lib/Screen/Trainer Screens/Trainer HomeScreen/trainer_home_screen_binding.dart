import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/trainer_home_screen_controller.dart';
import 'package:get/get.dart';

class TrainerHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerHomeScreenController());
    // Get.lazyPut(() => PlanOverviewConroller());
  }
}
