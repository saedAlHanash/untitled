import 'dart:io';

import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Data/Api/api_result.dart';
import '../../Utils/storage_controller.dart';
import '../../Utils/utils.dart';
import '../../helper/cache_helper.dart';

Future<void> openPage(String url) async {
  final googleUrl = Uri.parse(url);
  await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
}

class SplashController extends GetxController {
  String title = 'FitnesStorm';

  AuthRepository authRepository = AuthRepository();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (await checkForceUpdate()) {
        showUpdateDialog(
          Get.context!,
          child: const UpdateDialog(),
          omCancel: (b) {
            if (b) {
              if (Platform.isIOS) {
                openPage('https://apps.apple.com/us/app/fitness-storm/id6463420120');
              } else {
                openPage(
                    'https://play.google.com/store/apps/details?id=com.chi.fitnessStorm');
              }
            }

            return;
          },
        );
        return;
      }
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
