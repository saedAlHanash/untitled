import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class DayImage extends StatelessWidget {
  final String imageUrl;
  final String dayNumber;
  final int totalMinutes;
  final int numberOfExercises;

  const DayImage({
    super.key,
    required this.imageUrl,
    required this.dayNumber,
    required this.totalMinutes,
    required this.numberOfExercises,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Get.width / 18,
        right: Get.width / 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: _buildExerciseImage(),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseImage() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            height: numberOfExercises < 3 ? Get.height / 6 : Get.height / 3.7,
            width: Get.width / 2.9,
            child: ImageMultiType(
              url: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: Get.height / 13,
          width: Get.width / 3.125,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black12.withOpacity(0.3)),
        ),
        _buildDayInfo()
      ],
    );
  }

  Widget _buildDayInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DrawableText(
          text: dayNumber,
          maxLines: 3,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height / 80),
          child: Row(
            children: [
              const Icon(
                Icons.access_time_sharp,
                color: Colors.white,
                size: 14,
              ),
              10.0.horizontalSpace,
              DrawableText(
                text: formatTimePerMinutes(totalMinutes),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        )
      ],
    );
  }

  String formatTimePerSeconds(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  String formatTimePerMinutes(int minutes) {
    return '${(Duration(minutes: minutes))}'.split('.')[0].padLeft(8, '0');
  }
}
