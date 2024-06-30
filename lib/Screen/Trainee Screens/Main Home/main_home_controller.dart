import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/Widget/navigation_bar_controller.dart';
import 'package:get/get.dart';

import '../../../main.dart';


class MainHomeController extends GetxController {
  AppNavigationBarController navController = AppNavigationBarController();

  String? token;

  final RxBool _isLoading = false.obs;

  @override
  Future<void> onInit() async {
    saveFCM();
    super.onInit();
  }

  bool get isLoading => _isLoading.value;


}
