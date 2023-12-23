import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saed_http/api_manager/api_service.dart';

import '../../../../Data/Api/api_result.dart';
import '../../../../Data/Repositories/auth_repository.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Utils/storage_controller.dart';
import '../../../../Utils/utils.dart';
import '../../../Data/Api/error_response.dart';
import '../../../Utils/dependency_injection.dart';

class SigninController extends GetxController {
  final RxBool isScure = true.obs;
  final RxString message = ''.obs;

  bool isPhone = false;
  String phone = '';
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
    FirebaseAuth.instance.signOut();
    super.onInit();
  }

  TextEditingController get emailController => _emailController.value;

  TextEditingController get passwordController => _passowrdController.value;

  bool get isTrainer => _isTrainer.value;

  set isTrainer(value) => _isTrainer.value = value;

  // AccessToken? _accessToken;

  login() async {
    if (!emailController.text.trim().isEmail && !isPhone) {
      message.value = 'invalid_email'.tr;
      Utils.openSnackBar(title: 'invalid Email', textColor: Colors.white);
      return;
    }
    if (!emailController.text.trim().isPhoneNumber && isPhone) {
      Utils.openSnackBar(title: 'invalid_phone'.tr, textColor: Colors.white);
      return;
    }
    if (passwordController.text.isEmpty) {
      Utils.openSnackBar(title: 'password_is_required'.tr, textColor: Colors.white);
      return;
    }

    if (isPhone) {
      Utils.openLoadingDialog();
      final option = Utils.getOptions(accept: true);
      final headers = <String, String>{};
      option.headers?.forEach((key, value) {
        headers[key] = value.toString();
      });
      final result = await APIService().postApi(
        url: 'mobile/user/auth/phoneLogin',
        header: headers,
        body: {
          "mobile": phone,
          "password": passwordController.text,
        },
      );

      Utils.closeDialog();

      if (result.statusCode >= 200 && result.statusCode < 210) {
        final model = LoginPhone.fromJson(jsonDecode(result.body));
        _storageController.token = model.data.accessToken;
        _storageController.rememberToken = model.data.refreshToken;
        _storageController.id = model.data.id;
        _storageController.userType = 'trainee';
        _storageController.methodTakeAuthentication = '';
        getProfile();
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

      await storeFcm(token);
      Get.back();

      isTrainer
          ? Get.offAllNamed(AppRoutes.trainerHomePage)
          : Get.offAllNamed(AppRoutes.mainHome);
    } else {
      Get.back();
      message.value = res.message!;
    }
  }

  signInGoogle() async {
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
          await storeFcm(token);
          getProfile();
          Get.back();
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

  signOut() async {
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

class LoginPhone {
  LoginPhone({
    required this.data,
  });

  final Data data;

  factory LoginPhone.fromJson(Map<String, dynamic> json) {
    return LoginPhone(
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.isFirstTime,
    required this.isConfirmed,
    required this.confirmationCode,
  });

  final String id;
  final String accessToken;
  final String refreshToken;
  final bool isFirstTime;
  final bool isConfirmed;
  final num confirmationCode;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"] ?? "",
      accessToken: json["access_token"] ?? "",
      refreshToken: json["refresh_token"] ?? "",
      isFirstTime: json["is_first_time"] ?? false,
      isConfirmed: json["is_confirmed"] ?? false,
      confirmationCode: json["confirmation_code"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "is_first_time": isFirstTime,
        "is_confirmed": isConfirmed,
        "confirmation_code": confirmationCode,
      };
}
