import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:get/get.dart';

import '../../Data/Api/api_result.dart';
import '../../Utils/storage_controller.dart';
import '../../helper/cache_helper.dart';

class SplashController extends GetxController {
  String title = 'FitnesStorm';

  AuthRepository authRepository = AuthRepository();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      try {
        var res;
        if (StorageController().userType == 'trainer') {
          res = await authRepository.refreshTrainerToken();
          if (res.type == ApiResultType.success) {
            StorageController().token = res.data['access_token'];
            // Utils.openSnackBar(title: res.data['access_token']);
            Get.offAllNamed(AppRoutes.trainerHomePage);
          } else {
            if (CacheHelper.getData(key: 'sticky_otp') ?? false) {
              Get.offNamed(AppRoutes.otp, arguments: ['', false]);
              return;
            }
            if (StorageController().token.isEmpty) {
              Get.offNamed(AppRoutes.signIn);
            } else {
              Get.offAllNamed(AppRoutes.trainerHomePage);
            }
          }
        } else {
          res = await authRepository.refreshUserToken();
          if (res.type == ApiResultType.success) {
            StorageController().token = res.data['access_token'];
            // Utils.openSnackBar(title: res.data['access_token']);
            Get.offAllNamed(AppRoutes.mainHome);
          } else {
            if (CacheHelper.getData(key: 'sticky_otp') ?? false) {
              Get.offNamed(AppRoutes.otp, arguments: ['', false]);
              return;
            }
            if (StorageController().token.isEmpty) {
              Get.offNamed(AppRoutes.signIn);
            } else {
              Get.offAllNamed(AppRoutes.mainHome);
            }
          }
        }
      } catch (e) {
        //log(e.toString());
      }
    });
  }
}
