import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_controller.dart';
import 'package:get/get.dart';

class PlanOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlanOverviewController());
  }
}
