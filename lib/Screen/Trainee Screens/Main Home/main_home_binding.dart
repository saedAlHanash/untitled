import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Screen/search_screen_controller.dart';
import 'package:get/get.dart';

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchScreenController());
  }
}
