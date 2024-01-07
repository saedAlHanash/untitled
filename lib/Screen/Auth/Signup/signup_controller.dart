import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saed_http/api_manager/api_service.dart';

import '../../../../Data/Repositories/auth_repository.dart';
import '../../../../Utils/storage_controller.dart';
import '../../../Data/Api/error_response.dart';
import '../Signin/signin_controller.dart';

class SignupController extends GetxController {
  final RxString message = ''.obs;
 final  bool isPhone = false;
  String phone = '';
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
      return;
    }

    if (!emailEditingController.text.trim().isEmail && !isPhone) {
      Utils.openSnackBar(title: 'invalid_email'.tr, textColor: Colors.white);
      return;
    }
    if (!emailEditingController.text.trim().isPhoneNumber && isPhone) {
      Utils.openSnackBar(title: 'invalid_phone'.tr, textColor: Colors.white);
      return;
    }

    if (passwordEditingController.text.isEmpty) {
      Utils.openSnackBar(title: 'password_is_required'.tr, textColor: Colors.white);
      return;
    }
    if (nameEditingController.text.isEmpty) {
      Utils.openSnackBar(title: 'name_is_required'.tr, textColor: Colors.white);
      return;
    }

    if (isPhone) {
      Utils.openLoadingDialog();
      final option = Utils.getOptions(accept: true);
      final headers = <String, String>{};
      option.headers?.forEach((key, value) {
        headers[key] = value.toString();
      });
      final body = <String, dynamic>{
        "name": nameEditingController.text,
        "password": passwordEditingController.text,
        "mobile": phone,
        "isTest": false,
      };
      final result = await APIService().postApi(
        url: 'mobile/user/auth/phone_register',
        header: headers,
        body: body,
      );

      Utils.closeDialog();

      if (result.statusCode >= 200 && result.statusCode < 210) {
        final model = LoginPhone.fromJson(jsonDecode(result.body));
        _storageController.token = model.data.accessToken;
        _storageController.rememberToken = model.data.refreshToken;
        _storageController.id = model.data.id;
        _storageController.userType = 'trainee';
        _storageController.methodTakeAuthentication = '';

        if (!model.data.isConfirmed) {
          Get.offNamed(AppRoutes.otp, arguments: [phone, false]);
        } else {
          Get.offAllNamed(AppRoutes.mainHome);
        }
      } else {
        final error = ErrorResponse.fromJson(jsonDecode(result.body)).message ??
            result.statusCode.toString();
        Utils.openSnackBar(title: error, textColor: Colors.white);
      }

      return;
    }

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
        res = await _authRepository.traineeTakeAuthenticationByGoogleAccount(
            x.user!.email!, x.user!.displayName!, x.user!.uid);
        // loggerObject.w(res.statusCode);
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
          GoogleSignIn().signOut();
          Get.back();
          message.value = res.message!;
        }
      } else {
        GoogleSignIn().signOut();
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
