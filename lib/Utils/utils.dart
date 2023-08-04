import 'dart:async';
 

import 'package:dio/dio.dart';
import 'package:fitness_storm/Utils/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
    Widget cancelButton = TextButton(
        child: Text(
          'cancel'.tr,
        ),
        onPressed: () => Get.back());

    Widget continueButton = TextButton(
        child: Text(
          textContinue ?? 'continue'.tr,
        ),
        onPressed: () => {Get.back(), onContinueButtonPressed()});

    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        // title: Text('alert'.tr),
        content: Text(message),
        actions: [cancelButton, continueButton]);

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
    Options options = Options(headers: {'lang': Get.locale!.languageCode});

    /* if (contentType || all) {
       options.contentType = 'application/x-www-form-urlencoded';
     }*/

    if (accept || all || withRefreshToken) {
      options.headers!.addAll({
        'accept': 'application/json',
      });
    }
    if (withToken || all || customToken.isNotEmpty) {
      //log(StorageController().token);
      options.headers!.addAll({
        'authorization': customToken.isNotEmpty
            ? 'Bearer $customToken'
            : 'Bearer ${StorageController().token}',
        'timeZone': DateTime.now().timeZoneName,
        'lang': Get.locale!.languageCode,
      });
    }
    if (withRefreshToken) {
      //log('RefreshToken');
      //log(StorageController().rememberToken);
      options.headers!.addAll({
        'authorization': 'Bearer ${StorageController().rememberToken}',
        'lang': Get.locale!.languageCode,
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
