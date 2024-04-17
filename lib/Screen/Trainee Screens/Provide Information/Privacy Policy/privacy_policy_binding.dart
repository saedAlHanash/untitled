import 'package:get/instance_manager.dart';

import 'privacy_policy_controller.dart';

class AboutUsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}
