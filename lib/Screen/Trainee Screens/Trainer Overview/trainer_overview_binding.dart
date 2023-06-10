import 'package:fitness_storm/Screen/Trainee%20Screens/Trainer%20Overview/trainer_overview_controller.dart';
import 'package:get/get.dart';

class TrainerOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerOverviewController());
  }
}
