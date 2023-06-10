import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Data/Api/api_result.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Utils/utils.dart';

class ForgetPasswordEmailController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final Rx<TextEditingController> _emailController =
      TextEditingController().obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  TextEditingController get emailController => _emailController.value;

  reset() async {
    if (emailController.text.isEmpty) {
      Utils.openSnackBar(
          title: 'email_is_required'.tr, textColor: Colors.white);
      return;
    }
    if (!emailController.text.trim().isEmail) {
      Utils.openSnackBar(title: 'invald_email'.tr, textColor: Colors.white);
      return;
    }

    Utils.openLoadingDialog();
    var res = await _authRepository.forgetPassword(emailController.text);
    if (res.type == ApiResultType.success) {
      Get.back();
      Utils.openSnackBar(title: 'check_your_email'.tr, textColor: Colors.white);
      Get.offAllNamed(AppRoutes.otp, arguments: [emailController.text, true]);
    } else {
      Get.back();
      Utils.openSnackBar(title: res.message!, textColor: Colors.white);
    }
  }
}
