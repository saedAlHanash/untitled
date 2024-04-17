import 'package:fitness_storm/Screen/Trainee%20Screens/Progress%20Screen/progress_screen_controller.dart';
import 'package:get/instance_manager.dart';

class ProgressScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProgressScreenController());
  }
}
