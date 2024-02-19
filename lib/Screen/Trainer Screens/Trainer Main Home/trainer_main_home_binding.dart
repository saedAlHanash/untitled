import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Screen/search_screen_controller.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Calender/trainer_calender_controller.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/trainer_home_screen_controller.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_controller.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/trainer_profile_controller.dart';
import 'package:get/get.dart';

import '../../Trainee Screens/Progress Screen/progress_screen_controller.dart';
import '../../Trainee Screens/Search Screen/search_screen_controller.dart';
import '../../Trainee Screens/Trainee_Profile/trainee_profile_controller.dart';
import '../../Trainee Screens/Workout Screen/workout_screen_controller.dart';
import 'trainer_main_home_controller.dart';

class TrainerMainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerMainHomeController());
    Get.lazyPut(() => TrainerHomeScreenController());
    Get.lazyPut(() => TrainerSearchScreenController());
    Get.lazyPut(() => TrainerWalletController());
    Get.lazyPut(() => TrainerCalenderController());
    Get.lazyPut(() => TrainerProfileController());
    //
    // Get.lazyPut(() => WorkoutScreenController());
    // Get.lazyPut(() => SearchScreenController());
    // Get.lazyPut(() => ProgressScreenController());
    // Get.lazyPut(() => TraineeProfileController());
  }
}
