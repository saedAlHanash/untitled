import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class ContinueTrainingItem extends GetView<HomeScreenController> {
  final String planImageUrl;
  final String planName;
  final double planProgress;
  final int nextDayNumber;

  // final String trainerName;

  const ContinueTrainingItem({
    Key? key,
    required this.planImageUrl,
    required this.planName,
    required this.planProgress,
    required this.nextDayNumber,
    // required this.trainerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPlanImage(
              planImageUrl: planImageUrl, planProgress: planProgress),
          _buildTrainerInfo(
            planName: planName,
            // trainerName: trainerName,
          )
        ],
      ),
    );
  }

  Widget _buildTrainerInfo({
    required String planName,
    // required String trainerName,
  }) {
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              planName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          FittedBox(
              child: Text('next_up'.tr + ' : $nextDayNumber Day',
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
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: MediaQuery.of(Get.context!).size.height / 5,
            width: MediaQuery.of(Get.context!).size.width / 2.5,
            child: ImageMultiType(url:Constants.imageUrl + planImageUrl,
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: Get.height / 90,
          left: Get.width / 90,
          child: Container(
            height: Get.height / 30,
            padding: EdgeInsets.all(Get.width / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.black.withOpacity(0.6)),
            child: Row(
              children: [
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      value: planProgress,
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ),
                ),
                Text(
                  '$percentage% Completed',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
