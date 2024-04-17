import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/trainer_profile_controller.dart';
import 'package:get/instance_manager.dart';

class TrainerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerProfileController());
  }
}
