import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:fitness_storm/Utils/Constants/custome_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class ContinueTrainingItem extends GetView<HomeScreenController> {
  // final String trainerName;

  const ContinueTrainingItem({
    Key? key,
    required this.planImageUrl,
    required this.planName,
    required this.planProgress,
    required this.nextDayNumber,
    // required this.trainerName,
  }) : super(key: key);

  final int nextDayNumber;
  final String planImageUrl;
  final String planName;
  final double planProgress;

  Widget _buildTrainerInfo(
    context, {
    required String planName,
    // required String trainerName,
  }) {
    // Check if the current locale is English
    var isEnglish = Get.locale?.languageCode == 'en';
    return Padding(
      padding: isEnglish
          ? EdgeInsets.only(
              top: 10, left: MediaQuery.of(context).size.width * 0.03)
          : EdgeInsets.only(
              top: 10, right: MediaQuery.of(context).size.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              planName,
              style: TextStyle(
                color: Get.theme.colorScheme.secondary,
                fontSize: CustomeAppTheme.fontSizeMedium,
              ),
            ),
          ),
          FittedBox(
              child: Text('next_up'.tr + ' : Day $nextDayNumber',
                  style: TextStyle(color: Get.theme.primaryColor)))
        ],
      ),
    );
  }

  Widget _buildPlanImage(
      {required String planImageUrl, required planProgress}) {
    int percentage = (planProgress * 100).round();
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            child: ImageMultiType(url:
              Constants.imageUrl + planImageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(

          top: 18,
          left: Get.width / 80,
          child: Container(
            height: Get.height / 26,
            padding: EdgeInsets.all(Get.width / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.black.withOpacity(0.6)),
            child: Row(
              children: [
                Text(
                  '$percentage% ' + 'completed'.tr,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPlanImage(
            planImageUrl: planImageUrl, planProgress: planProgress),
        _buildTrainerInfo(
          context,
          planName: planName,
          // trainerName: trainerName,
        )
      ],
    );
  }
}
