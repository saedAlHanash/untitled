import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Result/search_result_controller.dart';
import 'package:get/instance_manager.dart';

class SearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchResultController());
  }
}
