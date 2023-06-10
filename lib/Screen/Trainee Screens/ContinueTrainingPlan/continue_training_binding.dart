import 'package:fitness_storm/Screen/Trainee%20Screens/ContinueTrainingPlan/continue_training_controller.dart';
import 'package:get/get.dart';

class ContinueTrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContinueTrainingController());
  }
}
