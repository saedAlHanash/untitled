import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/info_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';

class UserProfileInfoButtons extends StatelessWidget {
  const UserProfileInfoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InfoButton(
                title: 'about_us'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.aboutAs);
                },
              ),
            ),
            SizedBox(width: Get.width / 30),
            Expanded(
              child: InfoButton(
                title: 'privacy_policy'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.privacyPolicy);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InfoButton(
                title: 'FAQs'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.FAQs);
                },
              ),
            ),
            SizedBox(width: Get.width / 30),
            Expanded(
              child: InfoButton(
                title: 'Terms_and_Condition'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.termsAndCondition);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
