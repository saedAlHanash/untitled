import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Screen/search_screen_controller.dart';
import 'package:get/instance_manager.dart';

class TrainerSearchScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerSearchScreenController());
  }
}
