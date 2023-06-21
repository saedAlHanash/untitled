import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/trainee_profile_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SubscriptionPlanButton extends GetWidget<TraineeProfileController> {
  const SubscriptionPlanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height / 16.24,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: Get.height / 27),
      child: ElevatedButton(
        onPressed: () => Get.toNamed(AppRoutes.subscriptionScreen),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Get.theme.colorScheme.primary),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('asset/Images/subscription.svg'),
            SizedBox(width: Get.width / 100),
            Text('subscription_plans'.tr,
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
