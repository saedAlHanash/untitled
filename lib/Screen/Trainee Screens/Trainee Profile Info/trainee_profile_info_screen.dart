import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/Widget/Survey%20Info/survey_info_body.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/Widget/trainee_edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Trainee_Profile/trainee_profile_controller.dart';
import 'Widget/Profile Details/profile_details_body.dart';

class TraineeProfileInfoScreen extends GetWidget<TraineeProfileController> {
  const TraineeProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('profile_info'.tr),
        titleTextStyle:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TraineeEditProfile(),
              const ProfileDetailsBody(),
              const SurveyInfoBody(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Get.theme.primaryColor,
                    onPressed: () async {
                      await controller.editProfile();
                    },
                    child: Text(
                      'edit_profile'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.grey[300],
                    onPressed: () async {
                      await controller.deleteAccount();
                    },
                    child: Center(
                      child: Text(
                        'delete_account'.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
