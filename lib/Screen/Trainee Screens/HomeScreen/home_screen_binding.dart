import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:get/get.dart';

import '../PlanOverView/plan_overview_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    // Get.lazyPut(() => PlanOverviewController());
  }
}
