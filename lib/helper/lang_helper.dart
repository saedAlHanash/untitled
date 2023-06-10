import 'package:fitness_storm/helper/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Utils/Routes/app_pages.dart';

class LanguagesController extends GetxController {
  final RxString _selectedLanguage = RxString('en');

  String get selectedLanguage =>
      CacheHelper.getData(key: 'lang') ?? _selectedLanguage.value;

  Future<void> setLanguage(
    String language,
  ) async {
    await CacheHelper.saveData(key: 'lang', value: language);
    _selectedLanguage.value = language;
    Get.updateLocale(Locale(language));
    Get.offAllNamed(AppRoutes.mainHome);
  }
}
