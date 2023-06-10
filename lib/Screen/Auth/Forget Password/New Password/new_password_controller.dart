import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Data/Api/api_result.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Utils/utils.dart';

class NewPasswordController extends GetxController {
  late final String email;
  late final String token;

  final AuthRepository _authRepository = AuthRepository();
  final Rx<TextEditingController> _confirmPasswordController =
      TextEditingController().obs;

  final RxBool _isConfirmPasswordScure = true.obs;
  final RxBool _isPasswordScure = true.obs;
  final Rx<TextEditingController> _passwordController =
      TextEditingController().obs;

  @override
  void onInit() {
    email = Get.arguments[0];
    token = Get.arguments[1];
    super.onInit();
  }

  TextEditingController get passwordController => _passwordController.value;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController.value;

  bool get isPasswordScure => _isPasswordScure.value;

  bool get isConfirmPasswordScure => _isConfirmPasswordScure.value;

  set isPasswordScure(value) => _isPasswordScure.value = value;

  set isConfirmPasswordScure(value) => _isConfirmPasswordScure.value = value;

  confirm() async {
    if (passwordController.text.isEmpty) {
      Utils.openSnackBar(
          title: 'password_is_required'.tr, textColor: Colors.white);
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      Utils.openSnackBar(
          title: 'confirm_password_is_required'.tr, textColor: Colors.white);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Utils.openSnackBar(
          title: 'password_doesn\'t_match'.tr, textColor: Colors.white);
      return;
    }

    Utils.openLoadingDialog();
    var res =
        await _authRepository.setNewPassword(passwordController.text, token);
    if (res.type == ApiResultType.success) {
      Get.back();
      Utils.openSnackBar(title: 'Success'.tr, textColor: Colors.white);
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      Get.back();
      Utils.openSnackBar(title: res.message!, textColor: Colors.white);
    }
  }
}
