import 'package:fitness_storm/core/util/shared_preferences.dart';

import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LanguagesController extends GetxController {

  String get selectedLanguage =>
      AppSharedPreference.getLocal;

  Future<void> setLanguage(String language, {bool fromAuthPage = false}) async {
    await AppSharedPreference.cashLocal(language);

    Get.updateLocale(Locale(language));
    if(fromAuthPage){
      startLogin();
    }else{
      startHome();
    }
  }
}
