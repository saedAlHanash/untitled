import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/chat_controller.dart';
import 'package:get/instance_manager.dart';

class ChatBining extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
