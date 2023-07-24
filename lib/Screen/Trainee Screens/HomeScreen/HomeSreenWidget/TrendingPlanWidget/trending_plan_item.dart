import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/images/image_multi_type.dart';

class TrendingPlanItem extends GetView<HomeScreenController> {
  const TrendingPlanItem({
    Key? key,
    required this.planImageUrl,
    required this.planName,
    required this.trainerName,
  }) : super(key: key);

  final String planImageUrl;
  final String planName;
  final String trainerName;

  Widget _buildPlanImage({required String planImageUrl}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ImageMultiType(url:
        Constants.imageUrl + planImageUrl,
        width: MediaQuery.of(Get.context!).size.width / 2,
        height: MediaQuery.of(Get.context!).size.width / 2,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: _buildPlanImage(planImageUrl: planImageUrl),
    );
  }
}
