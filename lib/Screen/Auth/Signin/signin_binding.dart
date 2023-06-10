import 'package:fitness_storm/Screen/Auth/Forget%20Password/New%20Password/new_password_controller.dart';
import 'package:fitness_storm/Screen/Auth/Signin/signin_controller.dart';
import 'package:get/get.dart';

import '../Forget Password/Forget Password Email/forget_password_controller.dart';

class SigninBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SigninController());
    Get.lazyPut(() => ForgetPasswordEmailController());
    Get.lazyPut(() => NewPasswordController());
  }
}
