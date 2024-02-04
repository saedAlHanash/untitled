import 'package:fitness_storm/Screen/Trainee%20Screens/Trainer%20Overview/trainer_overview_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Model/trainer.dart';
import 'bio_check_widget.dart';

class TrainerBioWidget extends StatelessWidget {
  const TrainerBioWidget({required this.trainer, super.key});

  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Get.locale?.languageCode == 'en';
    return Column(
      children: [
        InkWell(
          onTap: () => Get.toNamed(AppRoutes.bookPrivateSession, arguments: [
            trainer.name,
            trainer.image,
            trainer.id.toString(),
          ]),
          child: Container(
            height: Get.height / 20,
            color: Get.theme.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'available_session'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${trainer.privateSessionPrice} ${'sar/hour'.tr}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Get.toNamed(AppRoutes.bookPrivateSession,
                          arguments: [
                           trainer.name,
                           trainer.image,
                           trainer.id.toString()
                          ]),
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          color: const Color(0xFF9F86C1),
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: Get.height / 27),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BioCheckWidget(
                        title: 'WORKOUT_PLANS'.tr,
                        value: trainer.numberOfPlans.toString()),
                    BioCheckWidget(
                        title: 'SUBSCRIBERS_cap'.tr,
                        value: trainer.numberOfSubscribers.toString()),
                    BioCheckWidget(
                        title: 'private_hours'.tr,
                        value: '+${trainer.numberOfPrivateHours}'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: Get.height / 27,
                  left: Get.width / 16,
                  right: Get.width / 16,
                ),
                child: Center(
                  child: Text(
                    trainer.bio,
                    textAlign: isEnglish ? TextAlign.left : TextAlign.left,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
