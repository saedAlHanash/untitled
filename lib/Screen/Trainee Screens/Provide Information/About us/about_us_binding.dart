import 'package:get/instance_manager.dart';

import 'about_us_controller.dart';

class AboutUsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}
