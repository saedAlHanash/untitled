import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  TextEditingController serachController = TextEditingController();

  onSearch() async {
    if (serachController.text.isEmpty) {
      return;
      // Utils.openSnackBar(title: 'Type_Anything_To_Search_It'.tr);
    }
    startSearchResultPage(serachController.text);
    // Get.toNamed(AppRoutes.searchResultSceen, arguments: serachController.text);
  }
}
