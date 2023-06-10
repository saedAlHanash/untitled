import 'package:get/get.dart';

import 'forget_password_controller.dart';

class ForgetPasswordEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordEmailController());
  }
}
