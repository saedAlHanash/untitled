import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/my_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../../core/models/plan_model.dart';

class FeaturedPlanItem extends GetWidget {
  const FeaturedPlanItem({super.key, required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      padding: const EdgeInsets.all(15),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          RoundImageWidget(
            url: plan.image,
            radios: 12.0.r,
            height: 1.0.sh,
            width: 1.0.sw,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 1.0.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15.r),
                  top: Radius.circular(15.r),
                ),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: ListTile(
                leading: RoundImageWidget(
                  url: plan.trainer.image,
                  height: 50.0.r,
                  width: 50.0.r,
                  radios: 200.0,
                ),
                title: DrawableText(
                  text: plan.name,
                  size: 18.0.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontManager.cairoBold.name,
                  color: Colors.white,
                ),
                subtitle: DrawableText(
                  text: plan.trainer.name,
                  fontWeight: FontWeight.bold,
                  color: AppColorManager.mainColorLight,
                ),
              ),
            ),
          ),
        ],
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
                plan.trainer.name,
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
