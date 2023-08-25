import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/subscription_plan_button.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/trainee_profile_body.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/user_profile_info_buttons.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/trainee_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Utils/storage_controller.dart';
import 'Widget/trainee_profile_header.dart';
import 'Widget/trainer_button.dart';

class TraineeProfileScreen extends GetView<TraineeProfileController> {
  const TraineeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor, // status bar color
    ));
    // controller.getUserProfile();

    return Obx(
      () => SizedBox(
        width: Get.width,
        child: controller.isLoading
            ? Center(child: CircularProgressIndicator(color: Get.theme.primaryColor))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TraineeProfileHeader(),
                      if (StorageController().id != '262') //add this for apple store
                        const SubscriptionPlanButton(),
                      const TraineeProfileBody(),
                      const TrainerButton(),
                      const UserProfileInfoButtons(),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
