 

import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:get/get.dart';

import '../../Data/Api/api_result.dart';
import '../../Utils/storage_controller.dart';

class SplashController extends GetxController {
  String title = 'FitnesStorm';

  AuthRepository authRepository = AuthRepository();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 5)).then((value) async {
      try {
        var res;
        if (StorageController().userType == 'trainer') {
          res = await authRepository.refreshTrainerToken();
          if (res.type == ApiResultType.success) {
            StorageController().token = res.data['access_token'];
            // Utils.openSnackBar(title: res.data['access_token']);
            Get.offAllNamed(AppRoutes.trainerHomePage);
          } else {
            Get.offNamed(AppRoutes.signIn);
            // String route = await AppPages().getInitPage();
            // Get.offAllNamed(route);
          }
        } else {
          res = await authRepository.refreshUserToken();
          if (res.type == ApiResultType.success) {
            StorageController().token = res.data['access_token'];
            // Utils.openSnackBar(title: res.data['access_token']);
            Get.offAllNamed(AppRoutes.mainHome);
          } else {
            Get.offNamed(AppRoutes.signIn);
            // String route = await AppPages().getInitPage();
            // Get.offAllNamed(route);
          }
        }
      } catch (e) {
       //log(e.toString());
      }
    });
  }
}
