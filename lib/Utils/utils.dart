import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitness_storm/Utils/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:saed_http/api_manager/api_service.dart';
import 'package:saed_http/pair_class.dart';

import '../Screen/Trainee Screens/coupon/ui/coupon_widget.dart';

class Utils {
  static final categoryItemWidth = Get.width * 0.44;
  static const categoryItemHeight = 242.0;
  static final productItemWidth = (Get.width / 2) - 22;
  static const productItemHeight = 218.0;

  static void openThreeSeconds() {
    if (Get.isDialogOpen!) return;
    const Duration(seconds: 3);
    Get.dialog(Container(
        alignment: Alignment.center,
        height: Get.width / 3,
        width: Get.width / 3,
        child: const CircularProgressIndicator(
          value: 1,
        )));
  }

  static void changeStatusBarColor(Color color,
      {Brightness brightness = Brightness.dark}) {
    //log('status bar changed');
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: brightness,
      ),
    );
  }

  static void openSnackBar(
      {String title = '',
      String message = '',
      Color textColor = Colors.white,
      int second = 3}) {
    Get.snackbar(
        backgroundColor: Get.theme.primaryColor.withOpacity(0.6),
        title,
        message,
        colorText: textColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: second));
  }

  static void openLoadingDialog() {
    if (Get.isDialogOpen!) return;
    Get.dialog(
        Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            child: const CircularProgressIndicator.adaptive()),
        barrierDismissible: false);
  }

  static void closeDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static void showAlertDialog(Function onContinueButtonPressed, String message,
      {String? textContinue}) {
    final cancelButton = TextButton(
        child: Text(
          'cancel'.tr,
        ),
        onPressed: () => Get.back());

    final continueButton = TextButton(
      child: Text(
        textContinue ?? 'continue'.tr,
      ),
      onPressed: () => {
        Get.back(),
        onContinueButtonPressed(),
      },
    );

    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        // title: Text('alert'.tr),
        content: Text(message),
        actions: [cancelButton, continueButton]);

    Get.dialog(alert);
  }

  static void showCancelSubscriptionAlertDialog(
    Function(String cancelReason) onContinueButtonPressed,
    String message, {
    String? textContinue,
  }) {
    final textController = TextEditingController();

    final cancelButton = TextButton(
        child: Text(
          'cancel'.tr,
        ),
        onPressed: () => Get.back());

    final continueButton = TextButton(
      child: Text(
        textContinue ?? 'continue'.tr,
      ),
      onPressed: () => {
        Get.back(),
        onContinueButtonPressed(textController.text),
      },
    );

    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        // title: Text('alert'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            SizedBox(height: Get.height / 90),
            MyTextFormNoLabelWidget(
              labelColor: Get.theme.primaryColor,
              label: 'cancel_reason'.tr,
              controller: textController,
              maxLines: 5,
            ),
          ],
        ),
        actions: [
          cancelButton,
          continueButton,
        ]);

    Get.dialog(alert);
  }

  static void openSearchSheet(
      Function onTap, TextEditingController searchTerm, bool isTrainer) {
    if (Get.isBottomSheetOpen!) return;
    Get.bottomSheet(
      Container(
        height: Get.height / 5,
        padding: EdgeInsets.symmetric(vertical: Get.height / 20.3),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isTrainer ? 'SEARCH_IN_TRAINER'.tr : 'SEARCH_IN_WORKOUT_PLANS'.tr,
              style: const TextStyle(
                  color: Color(0xFFA8A5A5), fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              height: Get.height / 21,
              padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
              margin: EdgeInsets.only(top: Get.height / 40.6),
              child: TextField(
                controller: searchTerm,
                decoration: InputDecoration(
                  hintText: 'What_are_you_searching_for?'.tr,
                  hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFD1D1D1)),
                  suffixIcon: GestureDetector(
                    onTap: () => onTap(),
                    child: Container(
                      width: Get.width / 12.5,
                      margin: EdgeInsets.all(Get.height / 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(500))),
                      child: SvgPicture.asset(
                        'asset/Images/search_bar.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Get.theme.primaryColor,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Get.theme.primaryColor, width: 2.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static DateTime? currentBackPressTime;

  static Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.rawSnackbar(message: 'BackToExit'.tr, backgroundColor: Colors.grey);
      return Future.value(false);
    }

    SystemNavigator.pop();
    return Future.value(true);
  }

  static Options getOptions({
    bool all = false,
    bool contentType = false,
    bool accept = false,
    bool acceptLanguage = false,
    bool withToken = false,
    bool withRefreshToken = false,
    String customToken = '',
  }) {
    Options options = Options(headers: {'lang': Get.locale?.languageCode ?? 'en'});

    /* if (contentType || all) {
       options.contentType = 'application/x-www-form-urlencoded';
     }*/

    if (accept || all || withRefreshToken) {
      options.headers!.addAll({
        'accept': 'application/json',
        'timeZone': DateTime.now().timeZoneName,
      });
    }
    if (withToken || all || customToken.isNotEmpty) {
      //log(StorageController().token);
      options.headers!.addAll({
        'authorization': customToken.isNotEmpty
            ? 'Bearer $customToken'
            : 'Bearer ${StorageController().token}',
        'timeZone': DateTime.now().timeZoneName,
        'lang': Get.locale?.languageCode ?? 'en',
      });
    }
    if (withRefreshToken) {
      //log('RefreshToken');
      //log(StorageController().rememberToken);
      options.headers!.addAll({
        'authorization': 'Bearer ${StorageController().rememberToken}',
        'lang': Get.locale!.languageCode,
        'timeZone': DateTime.now().timeZoneName,
      });
    }
    // if (customToken.isNotEmpty) {
    //   log('Custom Token');
    //   log(customToken);
    //   options.headers!.addAll({
    //     'change-password-token': customToken,
    //   });
    // }
    return options;
  }
}

SettingResult? versionControlModel;

Future<bool> checkForceUpdate() async {
  final appData = await PackageInfo.fromPlatform();
  final pair = await _apiSettings();

  if (pair.first == null) return false;

  versionControlModel = pair.first;

  num buildServer = 1000.0;

  final buildNumber = num.tryParse(appData.buildNumber);

  if (Platform.isIOS) {
    buildServer = pair.first!.minAppleVersion;
  } else {
    buildServer = pair.first!.minAndroidVersion;
  }

  if (buildNumber == null) return false;

  if (buildNumber < buildServer) return true;

  return false;
}

Future<Pair<SettingResult?, String?>> _apiSettings() async {
  APIService()
    ..baseUrl = 'api.fitnessstorm.org'
    ..innerHeader.addAll(
      {
        'authorization': 'Bearer ${StorageController().token}',
        'timeZone': DateTime.now().timeZoneName,
        'lang': Get.locale?.languageCode ?? 'en',
      },
    );

  final response = await APIService().getApi(
    url: 'api/terms',
  );

  if (response.statusCode == 200) {
    return Pair(SettingResult.fromJson(jsonDecode(response.body)), null);
  } else {
    return Pair(null, '');
  }
}

class SettingResult {
  SettingResult({
    required this.minAndroidVersion,
    required this.minAppleVersion,
    required this.isIosTest,
  });

  final num minAndroidVersion;
  final num minAppleVersion;
  final bool isIosTest;

  factory SettingResult.fromJson(List<dynamic> json) {
    return SettingResult(
      minAndroidVersion: num.tryParse(json.firstWhereOrNull(
                  (e) => (e)['label'] == 'min_android_version')['value'] ??
              "1000") ??
          1000,
      minAppleVersion: num.tryParse(json.firstWhereOrNull(
                  (e) => (e)['label'] == 'min_apple_version')['value'] ??
              "1000") ??
          1000,
      isIosTest: (json.firstWhereOrNull((e) => (e)['label'] == 'is_ios_test')['value'] ??
                  "false") ==
              'true'
          ? true
          : false,
    );
  }

  Map<String, dynamic> toJson() => {
        "min_android_version": minAndroidVersion,
        "min_apple_version": minAppleVersion,
        "is_ios_test": isIosTest,
      };
}

Future<bool> showUpdateDialog(BuildContext context,
    {required Widget child, bool? callable, Function(bool b)? omCancel}) async {
// show the dialog
  final result = await showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.3),
    barrierDismissible: false,
    builder: (BuildContext context) => child,
  );
  omCancel?.call(result ?? false);

  return (result ?? false);
}

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تحديث جديد متاح'),
      content: const Text('اصدار جديد من التطبيق يجب تحديث التطبيق للمتابعة'),
      actions: [
        ElevatedButton(
          child: const Text('تحديث'),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
