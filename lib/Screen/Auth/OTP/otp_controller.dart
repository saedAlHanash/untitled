import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/utils.dart';
import '../../../helper/cache_helper.dart';

class OTPController extends GetxController {
  late final bool isReset;

  final AuthRepository _authRepository = AuthRepository();
  final RxString _email = ''.obs;
  final Rx<TextEditingController> _otpController = TextEditingController().obs;

  bool isPhone = false;

  @override
  void onInit() {
    email = Get.arguments[0];
    isReset = Get.arguments[1];

    isPhone = email.isNotEmpty && int.tryParse(email.substring(0, 1)) != null;
    if (!isReset) {
      CacheHelper.saveData(key: 'sticky_otp', value: true);
    }
    super.onInit();
  }

  TextEditingController get otpController => _otpController.value;

  String get email => _email.value;

  set email(value) => _email.value = value;

  void submit() async {
    //log(otpController.text);
    if (otpController.text.isEmpty) {
      Utils.openSnackBar(title: 'please_enter_oTP_code'.tr, textColor: Colors.white);
      return;
    } else {
      Utils.openLoadingDialog();

      ApiResult result = await _authRepository.submitUserOTP(otpController.text);

      if (result.type == ApiResultType.success) {
        Utils.openSnackBar(title: 'Success'.tr, textColor: Colors.white);
        CacheHelper.saveData(key: 'sticky_otp', value: false);
        Get.toNamed(AppRoutes.surveyScreen);
      } else {
        Get.back();
        Utils.openSnackBar(title: result.message!, textColor: Colors.white);
      }
    }
  }

  void submitForgetPassword() async {
    //log('forgetpassword');
    //log(otpController.text);
    if (otpController.text.isEmpty) {
      Utils.openSnackBar(title: 'please_enter_oTP_code'.tr, textColor: Colors.white);
      return;
    } else {
      Utils.openLoadingDialog();

      ApiResult result =
          await _authRepository.submitForgetPasswordOTP(email, otpController.text);

      if (result.type == ApiResultType.success) {
        Utils.openSnackBar(title: 'Success'.tr, textColor: Colors.white);
        String token = result.data['token'];

        Get.toNamed(AppRoutes.forgetPasswordNewPassword, arguments: [email, token]);
        Utils.closeDialog();
      } else {
        Utils.closeDialog();
        Get.back();

        Utils.openSnackBar(title: result.message!, textColor: Colors.white);
      }
    }
  }

  void resendOTP() async {
    //log(otpController.text);
    Utils.openLoadingDialog();
    ApiResult result = await _authRepository.resendOTP();
    Utils.closeDialog();
    if (result.type == ApiResultType.success) {
      Utils.openSnackBar(
          title: 'verification_sent_successfully'.tr, textColor: Colors.white);
    } else {
      Utils.openSnackBar(title: result.message!, textColor: Colors.white);
    }
  }
}
