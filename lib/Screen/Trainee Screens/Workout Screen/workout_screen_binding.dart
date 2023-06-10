import 'package:fitness_storm/Screen/Trainee%20Screens/Workout%20Screen/workout_screen_controller.dart';
import 'package:get/instance_manager.dart';

class WorkoutScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkoutScreenController());
  }
}
