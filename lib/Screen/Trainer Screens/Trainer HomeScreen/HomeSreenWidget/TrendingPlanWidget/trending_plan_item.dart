import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class TrendingPlanItem extends GetView<HomeScreenController> {
  final String planImageUrl;
  final String planName;
  final String trainerName;

  const TrendingPlanItem({
        super.key,
    required this.planImageUrl,
    required this.planName,
    required this.trainerName,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPlanImage(planImageUrl: planImageUrl),
        ],
      ),
    );
  }

  Widget _buildPlanImage({required String planImageUrl}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SizedBox(
            height: MediaQuery.of(Get.context!).size.height / 5,
            width: MediaQuery.of(Get.context!).size.width / 2.5,
            child: ImageMultiType(url:  planImageUrl,
                fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(Get.width / 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    planName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    trainerName,
                    style: TextStyle(
                        color: Get.theme.colorScheme.secondary, fontSize: 9),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
