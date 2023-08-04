 

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../Data/Api/api_result.dart';
import '../../../../Data/Repositories/auth_repository.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Utils/storage_controller.dart';
import '../../../../Utils/utils.dart';
import '../../../Utils/dependency_injection.dart';

class SigninController extends GetxController {
  final RxBool isScure = true.obs;
  final RxString message = ''.obs;

  final AuthRepository _authRepository = AuthRepository();
  final Rx<TextEditingController> _emailController = TextEditingController().obs;

  final RxBool _isTrainer = false.obs;
  final Rx<TextEditingController> _passowrdController = TextEditingController().obs;

  final StorageController _storageController = StorageController();
  final TrainerAuthRepository _trainerAuthRepository = TrainerAuthRepository();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // 110440939124909573355

  @override
  void onInit() {
   //log('you are in trainee');
    super.onInit();
  }

  TextEditingController get emailController => _emailController.value;

  TextEditingController get passwordController => _passowrdController.value;

  bool get isTrainer => _isTrainer.value;

  set isTrainer(value) => _isTrainer.value = value;

  // AccessToken? _accessToken;

  login() async {
    if (emailController.text.isEmpty) {
      message.value = 'email_is_required'.tr;
      // Utils.openSnackBar(title: 'Email Is Required', textColor: Colors.white);
      return;
    } else if (!emailController.text.trim().isEmail) {
      message.value = 'invald_email'.tr;
      // Utils.openSnackBar(title: 'Invald Email', textColor: Colors.white);
      return;
    } else if (passwordController.text.isEmpty) {
      message.value = 'password_is_required'.tr;
      // Utils.openSnackBar(title: 'Password Is Required', textColor: Colors.white);
      return;
    } else {
      Utils.openLoadingDialog();
      ApiResult res;
      if (isTrainer) {
        res = await _trainerAuthRepository.trainerLogin(
            emailController.text, passwordController.text);
      } else {
        res = await _authRepository.traineeLogin(
            emailController.text, passwordController.text);
      }

      if (res.type == ApiResultType.success) {
        _storageController.token = res.data['access_token'];
        _storageController.rememberToken = res.data['refresh_token'];
        _storageController.id = res.data['id'];
        _storageController.userType = isTrainer ? 'trainer' : 'trainee';
        _storageController.methodTakeAuthentication = '';

        getProfile();
        //Todo should un comment this
        final token = await getToken();
        ////log('FFFCCCMMM $token');
        await storeFcm(token);
        Get.back();
        // Utils.openSnackBar(title: 'Login Success', textColor: Colors.white);
        isTrainer
            ? Get.offAllNamed(AppRoutes.trainerHomePage)
            : Get.offAllNamed(AppRoutes.mainHome);
      } else {
        Get.back();
        message.value = res.message!;

        // Utils.openSnackBar(title: res.message!, textColor: Colors.white);
      }
    }
  }

  sign_in_google() async {
    Utils.openLoadingDialog();
    try {
      final googleAccount = await GoogleSignIn().signIn();
      final googleAuthentication = await googleAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuthentication.accessToken,
          idToken: googleAuthentication.idToken);
      bool check = true;
      var x;
      try {
        x = await FirebaseAuth.instance.signInWithCredential(credential);

        ApiResult res;

        res = await _authRepository.traineeTakeAuthenticationByGoogleAccount(
            x.user!.email!, x.user!.displayName!, x.user!.uid);

        if (res.type == ApiResultType.success) {
          _storageController.token = res.data['access_token'];
          _storageController.rememberToken = res.data['refresh_token'];
          _storageController.id = res.data['id'];
          _storageController.userType = isTrainer ? 'trainer' : 'trainee';
          _storageController.methodTakeAuthentication = 'google';
          final token = await getToken();
         //log('FFFCCCMMM $token');
          await storeFcm(token);
          getProfile();
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
        check = true;
      } catch (e) {
        check = false;
      } finally {
        if (check) {
        } else {
          Utils.closeDialog();
          Utils.openSnackBar(title: 'not_login'.tr, message: message.value);
        }
      }
    } catch (e) {
      Utils.closeDialog();
     //   print(e);
    }
  }

  sign_out() async {
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
  }

  getToken() async {
    // StorageController storageController = StorageController();
    String? token = '';
    // token = await FirebaseMessaging.instance.getToken();
   //log('\x1B[32mUser Token $token');
    // storageController.fcm = token;
    return token;
  }

  storeFcm(String token) async {
    ApiResult result = await _authRepository.saveFCM(token);
   //log(result.type.toString());
  }
}
//keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore