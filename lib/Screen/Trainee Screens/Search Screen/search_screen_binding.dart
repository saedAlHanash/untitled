import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Screen/search_screen_controller.dart';
import 'package:get/instance_manager.dart';

class SearchScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchScreenController());
  }
}
