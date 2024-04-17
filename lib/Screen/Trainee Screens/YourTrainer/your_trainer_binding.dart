import 'package:get/get.dart';

import 'your_trainer_controller.dart';

class YourTrainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => YourTrainerController());
  }
}
