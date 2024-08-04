import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class FeaturedPlanItem extends GetWidget {
  final String planImageUrl;
  final String planName;
  final int totalWeeks;
  final int workoutFrequency;
  final String trainerProfileImageUrl;
  final String trainerName;

  // final String trainingType;

  const FeaturedPlanItem({
    super.key,
    required this.planImageUrl,
    required this.planName,
    required this.totalWeeks,
    required this.workoutFrequency,
    required this.trainerProfileImageUrl,
    required this.trainerName,
    // required this.trainingType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Stack(
        children: [
          _buildImageCard(planImageUrl),
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

  Widget _buildImageCard(String planImageUrl) {
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.height / 2,
      width: MediaQuery.of(Get.context!).size.width,
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ImageMultiType(url: planImageUrl, fit: BoxFit.cover),
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
    return Container(
      width: 0.93.sw,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15.r),
          top: Radius.circular(15.r),
        ),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTrainerInfo(
            trainerImageUrl: trainerImageUrl,
            trainerName: trainerName,
            width: 0.93.sw,
          ),
          _buildPlanInfoWidget(
            planName: planName,
            totalWeeks: totalWeeks,
            planFrequency: planFrequency,
            // trainingType: trainingType,
            width: 0.93.sw,
          )
        ],
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
            Center(
              child: Text(
                planName,
                style: const TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                trainerName,
                style: TextStyle(
                  color: Get.theme.colorScheme.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
          backgroundImage: CachedNetworkImageProvider(trainerImageUrl),
          radius: Get.width / 10,
        ),
      ),
    );
  }
}

//• ●
