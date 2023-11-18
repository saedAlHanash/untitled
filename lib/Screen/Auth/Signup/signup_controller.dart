import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../Data/Repositories/auth_repository.dart';
import '../../../../Utils/storage_controller.dart';

class SignupController extends GetxController {
  final RxString message = ''.obs;

  final AuthRepository _authRepository = AuthRepository();
  final Rx<TextEditingController> _confirmPasswordEditingController =
      TextEditingController().obs;

  final Rx<TextEditingController> _emailEditingController = TextEditingController().obs;

  final RxBool _isFemale = false.obs;
  final RxBool _isMale = false.obs;
  final RxBool _isScure = true.obs;
  final RxBool _isTrainer = false.obs;
  final Rx<TextEditingController> _nameEditingController = TextEditingController().obs;

  final Rx<TextEditingController> _passwordEditingController =
      TextEditingController().obs;

  final _storageController = StorageController();

  TextEditingController get emailEditingController => _emailEditingController.value;

  TextEditingController get passwordEditingController => _passwordEditingController.value;

  TextEditingController get confirmPasswordEditingController =>
      _confirmPasswordEditingController.value;

  TextEditingController get nameEditingController => _nameEditingController.value;

  bool get isMale => _isMale.value;

  bool get isFemale => _isFemale.value;

  bool get isTrainer => _isTrainer.value;

  bool get isScure => _isScure.value;

  set isMale(value) => _isMale.value = value;

  set isFemale(value) => _isFemale.value = value;

  set isTrainer(value) => _isTrainer.value = value;

  set isScure(value) => _isScure.value = value;

  void onCheckTrainer(bool? value) {
    //log(value.toString());
    isTrainer = value;
    update();
  }

  signup() async {
    if (emailEditingController.text.isEmpty) {
      Utils.openSnackBar(title: 'email_is_required'.tr, textColor: Colors.white);
    } else if (!emailEditingController.text.trim().isEmail) {
      Utils.openSnackBar(title: 'invald_email'.tr, textColor: Colors.white);
    } else if (passwordEditingController.text.isEmpty) {
      Utils.openSnackBar(title: 'password_is_required'.tr, textColor: Colors.white);
    } else if (nameEditingController.text.isEmpty) {
      Utils.openSnackBar(title: 'name_is_required'.tr, textColor: Colors.white);
    } else {
      Utils.openLoadingDialog();
      ApiResult res;
      res = await _authRepository.traineeSignup(emailEditingController.text,
          passwordEditingController.text, nameEditingController.text);

      if (res.type == ApiResultType.success) {
        _storageController.token = res.data['access_token'];
        Get.back();
        Utils.openSnackBar(title: 'check_your_email'.tr, textColor: Colors.white);
        Get.offAllNamed(AppRoutes.otp, arguments: [emailEditingController.text, false]);
      } else {
        Get.back();
        Utils.openSnackBar(title: res.message!, textColor: Colors.white);
      }
    }
  }

  getToken() async {
    StorageController storageController = StorageController();
    String? token = '';
    token = await FirebaseMessaging.instance.getToken();
    //log('\x1B[32mUser Token $token');
    storageController.fcm = token;
    return token;
  }

  signInGoogle() async {
    Utils.openLoadingDialog();
    final googleAccount = await GoogleSignIn().signIn();

    final googleAuthentication = await googleAccount!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken);
    bool check = true;
    var x;
    try {
      x = await FirebaseAuth.instance.signInWithCredential(credential);
      check = true;
    } catch (e) {
      check = false;
    } finally {
      if (check) {
        ApiResult res;
        // if (isTrainer) {
        //   res = await _trainerAuthRepository.trainerLogin(
        //       emailController.text, passwordController.text);
        // } else {
        res = await _authRepository.traineeTakeAuthenticationByGoogleAccount(
            x.user!.email!, x.user!.displayName!, x.user!.uid);
        // }
        if (res.type == ApiResultType.success) {
          _storageController.token = res.data['access_token'];
          _storageController.rememberToken = res.data['refresh_token'];
          _storageController.id = res.data['id'];
          _storageController.userType = isTrainer ? 'trainer' : 'trainee';
          _storageController.methodTakeAuthentication = 'google';
          final token = await getToken();
          //log('FFFCCCMMM $token');
          await storeFcm(token);
          Get.back();
          // Utils.openSnackBar(title: 'Login Success', textColor: Colors.white);
          if (isTrainer) {
            Get.offAllNamed(AppRoutes.trainerHomePage);
          } else {
            if (!res.data['is_first_time']) {
              Get.offAllNamed(AppRoutes.mainHome);
            } else {
              Get.toNamed(AppRoutes.surveyScreen);
            }
          }
        } else {
          Get.back();
          message.value = res.message!;
        }
      } else {
        Utils.closeDialog();
        Utils.openSnackBar(title: 'not_login'.tr, message: message.value);
      }
    }
  }

  storeFcm(String token) async {
    ApiResult result = await _authRepository.saveFCM(token);
    //log(result.type.toString());
  }

  signOut() async {
    await GoogleSignIn().signOut();
  }
}

//keytool -list -v -alias key0 -keystore fitness_sotrm
