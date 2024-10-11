import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Utils/utils.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';
import 'intro_page.dart';

bool canRecording = false;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> openPage(String url) async {
    final googleUrl = Uri.parse(url);
    await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
  }

  @override
  void initState() {
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

      if (!AppSharedPreference.isShowIntro) {
        Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(builder: (context) => IntroPage()),
        );
        return;
      }
      if (!AppProvider.isLogin) {
        startLogin();
        return;
      }

      startHome(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.0.sh,
        width: 1.0.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Get.theme.primaryColor,
              Get.theme.colorScheme.secondary,
            ],
          ),
        ),
        child: GestureDetector(
          onDoubleTap: () {
            canRecording = true;
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0).r,
              child: Lottie.asset(
                Assets.lottiesFitnessstormLogoAnimationWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
