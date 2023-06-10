import 'package:fitness_storm/Screen/Trainee%20Screens/Training/training_controller.dart';
import 'package:get/get.dart';

class TrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainingController());
  }
}
