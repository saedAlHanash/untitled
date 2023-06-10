import 'package:fitness_storm/Screen/Splash/splash_controller.dart';
import 'package:get/get.dart';

import '../Auth/Forget Password/Forget Password Email/forget_password_screen.dart';
import '../Auth/Signin/signin_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.lazyPut(() => SigninController());
    Get.lazyPut(() => const ForgetPasswordEmailScreen());
  }
}
