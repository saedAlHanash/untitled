import 'package:fitness_storm/Screen/Trainee%20Screens/day_overview/day_overview_controller.dart';
import 'package:get/get.dart';

class DayOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DayOverviewController());
  }
}
