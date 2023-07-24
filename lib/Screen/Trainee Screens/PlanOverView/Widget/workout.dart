import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Trainer Screens/Trainer Overview/Widget/ProfileHader/trainer_profile_image_widget.dart';

class Workout extends StatelessWidget {
  final String dayId;
  final String workoutId;
  final String imagePath;
  final int dayNumber;
  final String dayTitle;
  final String videoPreview;
  final int totalMinut;
  final bool isActivated;

  const Workout({
    Key? key,
    required this.imagePath,
    required this.dayId,
    required this.workoutId,
    required this.dayNumber,
    required this.dayTitle,
    required this.videoPreview,
    required this.totalMinut,
    required this.isActivated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.dayOverviewScreen, arguments: [
          workoutId,
          dayTitle,
          videoPreview,
          totalMinut,
          dayId,
          isActivated
        ]),
        // => Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         DayOverView(workoutName: dayTitle, id: workoutId),
        //   ),
        // ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: Center(
            child: Stack(
              children: [
                _buildWorkoutImage(imagePath),
                _buildCenterText(dayNumber, dayTitle, context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutImage(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image:CachedNetworkImageProvider(Constants.imageUrl + imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCenterText(
      int dayNumber, String dayTitle, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'day'.tr + ' $dayNumber',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Text(
            dayTitle,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
