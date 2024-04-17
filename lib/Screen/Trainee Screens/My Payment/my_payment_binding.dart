import 'package:fitness_storm/Screen/Trainee%20Screens/My%20Payment/my_payment_controller.dart';
import 'package:get/instance_manager.dart';

class MyPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyPaymentController());
  }
}
