import 'package:get/instance_manager.dart';

import 'terms_conditions_controller.dart';

class AboutUsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}
