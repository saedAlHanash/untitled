import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:get/instance_manager.dart';

class TraineeProfileInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TraineeProfileInfoController());
  }
}
