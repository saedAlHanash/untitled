import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TrainerSearchScreenController extends GetxController {
  TextEditingController serachController = TextEditingController();

  onSearch() async {
    if (serachController.text.isEmpty) {
      Utils.openSnackBar(title: 'Type_Anything_To_Search_It'.tr);
      return;
    }
    Get.toNamed(AppRoutes.trainerSearchResultSceen,
        arguments: serachController.text);
  }
}
