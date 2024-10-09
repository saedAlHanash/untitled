import 'dart:io';

import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/utils.dart';
import '../../router/app_router.dart';

Future<void> openPage(String url) async {
  final googleUrl = Uri.parse(url);
  await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
}

class SplashController extends GetxController {
  @override
  void onInit() {
    // Future.delayed(const Duration(seconds: 3)).then((value) async {
    //   if (await checkForceUpdate()) {
    //     showUpdateDialog(
    //       Get.context!,
    //       child: const UpdateDialog(),
    //       omCancel: (b) {
    //         if (b) {
    //           if (Platform.isIOS) {
    //             openPage('https://apps.apple.com/us/app/fitness-storm/id6463420120');
    //           } else {
    //             openPage(
    //                 'https://play.google.com/store/apps/details?id=com.chi.fitnessStorm');
    //           }
    //         }
    //
    //         return;
    //       },
    //     );
    //     return;
    //   }
    //
    //   if (!AppProvider.isLogin) {
    //     startLogin();
    //     return;
    //   }
    //
    //   startHome();
    // });
    super.onInit();
  }
}
