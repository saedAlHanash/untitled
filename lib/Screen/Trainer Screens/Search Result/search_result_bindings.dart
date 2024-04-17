import 'package:fitness_storm/Screen/Trainer%20Screens/Search%20Result/search_result_controller.dart';
import 'package:get/instance_manager.dart';

class TrainerSearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerSearchResultController());
  }
}
