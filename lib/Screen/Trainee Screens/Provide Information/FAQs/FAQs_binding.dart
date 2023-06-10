import 'package:get/instance_manager.dart';

import 'FAQs_controller.dart';

class FAQsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FAQsController());
  }
}
