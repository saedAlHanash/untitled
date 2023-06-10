import 'package:fitness_storm/Screen/Trainee%20Screens/Loading%20Start%20Training/loading_start_training_controller.dart';
import 'package:get/get.dart';

class LoadingStartTraingingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoadingStartTrainingController());
  }
}
