import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/filter_page_controller.dart';
import 'package:get/get.dart';

class FilterResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterPageController());
  }
}
