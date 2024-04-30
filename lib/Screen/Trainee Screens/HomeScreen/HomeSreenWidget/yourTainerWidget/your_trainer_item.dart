import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

class YourTrainersItem extends GetWidget {
  const YourTrainersItem({required this.trainer, super.key});

  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0.r,
      height: 230.0.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 30.0).r,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          RoundImageWidget(
            url: trainer.image,
            radios: 15.0.r,
            width: 220.0.r,
            height: 230.0.r,
            fit: BoxFit.fill,
          ),
          Container(
            width: 1.0.sw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Colors.black54, Colors.black26, Colors.black12],
              ),
            ),
            child: DrawableText(
              padding: const EdgeInsets.all(8.0).r,
              text: trainer.name,
              maxLines: 1,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
