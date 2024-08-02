import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class TrendingPlanItem extends GetView<HomeScreenController> {
  const TrendingPlanItem({
    super.key,
    required this.planImageUrl,
    required this.planName,
    required this.trainerName,
  });

  final String planImageUrl;
  final String planName;
  final String trainerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      margin: const EdgeInsets.all(10),
      child: ImageMultiType(
        url: planImageUrl,
        width: MediaQuery.of(Get.context!).size.width / 2,
        height: MediaQuery.of(Get.context!).size.width / 2,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
