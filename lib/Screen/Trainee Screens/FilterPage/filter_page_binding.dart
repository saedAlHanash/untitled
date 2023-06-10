import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/filter_page_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterResultPage/filter_result_controller.dart';
import 'package:get/get.dart';

class FilterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterPageController());
    Get.lazyPut(() => FilterResultController());
  }
}
