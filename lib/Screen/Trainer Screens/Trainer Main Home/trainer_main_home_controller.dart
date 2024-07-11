import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Main%20Home/Widget/trainer_navigation_bar_controller.dart';
import 'package:get/get.dart';

import '../../../main.dart';


class TrainerMainHomeController extends GetxController {
  TrainerAppNavigationBarController navController = TrainerAppNavigationBarController();

  String? token;

  @override
  Future<void> onInit() async {
    saveFCM();

    super.onInit();
  }


}
