import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Calender/trainer_calender_controller.dart';
import 'package:get/instance_manager.dart';

class TrainerCalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerCalenderController());
  }
}
