import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Widgets/plan_time_freqency.dart';
import 'package:image_multi_type/image_multi_type.dart';

class FeaturedPlanItem extends GetWidget {
  // final String trainingType;

  const FeaturedPlanItem({
    Key? key,
    required this.planImageUrl,
    required this.planName,
    required this.totalWeeks,
    required this.workoutFrequency,
    required this.trainerProfileImageUrl,
    required this.trainerName,
  }) : super(key: key);

  final String planImageUrl;
  final String planName;
  final int totalWeeks;
  final String trainerName;
  final String trainerProfileImageUrl;
  final int workoutFrequency;

  Widget _buildGradiantCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        // height: MediaQuery.of(Get.context!).size.height / 2,
        width: MediaQuery.of(Get.context!).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Get.theme.primaryColor.withOpacity(0.75),
              Get.theme.primaryColor.withOpacity(0.50),
              Get.theme.primaryColor.withOpacity(0.15),
              Get.theme.colorScheme.secondary.withOpacity(0.15),
              Get.theme.colorScheme.secondary.withOpacity(0.50),
              Get.theme.colorScheme.secondary.withOpacity(0.75)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String planImageUrl) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ImageMultiType(
          url: Constants.imageUrl + planImageUrl,
          height: MediaQuery.of(Get.context!).size.height / 2,
          // width: MediaQuery.of(Get.context!).size.width,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _buildPlanInfo({
    required String trainerImageUrl,
    required String trainerName,
    required String planName,
    required int totalWeeks,
    required int planFrequency,
    // required String trainingType,
  }) {
    var width = MediaQuery.of(Get.context!).size.width - 30;
    if (width < 0) width = 0;// add by saed
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: Container(
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.black54, Colors.black26, Colors.black12],
          ),
        ),
        // color: Colors.grey.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTrainerInfo(
              trainerImageUrl: trainerImageUrl,
              trainerName: trainerName,
              width: width,
            ),
            _buildPlanInfoWidget(
              planName: planName,
              totalWeeks: totalWeeks,
              planFrequency: planFrequency,
              // trainingType: trainingType,
              width: width,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlanInfoWidget({
    required String planName,
    required int totalWeeks,
    required int planFrequency,
    // required String trainingType,
    required double width,
  }) {
    return SizedBox(
      width: width / 1.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Center(
                child: Text(
                  planName,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FittedBox(
                child: Text(
                  trainerName,
                  style: TextStyle(
                    color: Get.theme.colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            PlanTimeFrequency(
              totalWeeks: totalWeeks,
              workoutFrequency: planFrequency,
              // trainingType: trainingType,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTrainerInfo({
    required String trainerImageUrl,
    required String trainerName,
    required double width,
  }) {
    return Container(
      width: width / 3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              CachedNetworkImageProvider(Constants.imageUrl + trainerImageUrl),
          radius: Get.width / 8,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Stack(
        children: [
          _buildImageCard(planImageUrl),
          _buildGradiantCard(),
          Positioned(
            bottom: 0,
            child: _buildPlanInfo(
              trainerImageUrl: trainerProfileImageUrl,
              trainerName: trainerName,
              planName: planName,
              totalWeeks: totalWeeks,
              planFrequency: workoutFrequency,
              // trainingType: trainingType,
            ),
          )
        ],
      ),
    );
  }
}

//• ●
