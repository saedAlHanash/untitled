import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Progress%20Screen/progress_screen_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Screen/search_screen_controller.dart';
import 'package:get/get.dart';

import '../Workout Screen/workout_screen_controller.dart';
import 'main_home_controller.dart';

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => WorkoutScreenController());
    Get.lazyPut(() => SearchScreenController());
    Get.lazyPut(() => ProgressScreenController());
    // Get.lazyPut(() => TraineeProfileController());
  }
}
