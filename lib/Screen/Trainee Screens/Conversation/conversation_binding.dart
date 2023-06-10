import 'package:fitness_storm/Screen/Trainee%20Screens/Conversation/conversation_controller.dart';
import 'package:get/instance_manager.dart';

class ConversationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConversationController());
  }
}
