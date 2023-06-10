import 'package:fitness_storm/Screen/Trainee%20Screens/BookPrivateSession/book_private_session_controller.dart';
import 'package:get/instance_manager.dart';

class BookPrivateSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookPrivateSessionController());
  }
}
