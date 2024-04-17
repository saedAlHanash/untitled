import 'package:fitness_storm/Screen/Trainee%20Screens/Notification/notification_controller.dart';
import 'package:get/instance_manager.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}
