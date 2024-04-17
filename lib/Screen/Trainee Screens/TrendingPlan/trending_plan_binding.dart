import 'package:fitness_storm/Screen/Trainee%20Screens/TrendingPlan/trending_plan_controller.dart';
import 'package:get/get.dart';

class TrendingPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrendingPlanController());
  }
}
