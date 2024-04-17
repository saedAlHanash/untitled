import 'package:fitness_storm/Screen/Trainee%20Screens/Bookmarked%20Screen/bookmarked_screen_controller.dart';
import 'package:get/instance_manager.dart';

class BookmarkedScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookmarkedScreenController());
  }
}
