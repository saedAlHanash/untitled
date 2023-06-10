import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Overview/trainer_overview_controller.dart';
import 'package:get/get.dart';

class TrainerTrainerOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerTrainerOverviewController());
  }
}
