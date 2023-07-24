import 'package:fitness_storm/Model/training_level.dart';
import 'package:fitness_storm/Model/training_location.dart';
import 'package:fitness_storm/Model/training_type.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Model/plan.dart';
import '../Utils/Routes/app_pages.dart';
import '../core/images/image_multi_type.dart';
import 'custom_chip.dart';
import 'trainer_profile_image.dart';

class SeeAllListItem extends StatelessWidget {
  final Plan plan;
  final Widget subTitle;
  final Function isPressed;
  final int index;

  const SeeAllListItem({
    Key? key,
    required this.plan,
    required this.subTitle,
    required this.isPressed,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.planOverview, arguments: plan.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildItemImage(
              imageUrl: plan.image!,
              planId: plan.id!,
              isBookmarked: plan.isBookMarked,
              isPressed: isPressed,
              index: index),
          buildItemInformation(
            planTitle: plan.name!,
            subTitle: subTitle,
            trainerImageUrl: plan.trainer!.profilePic!,
            trainerName: plan.trainer!.name!,
            trainingLevel: plan.trainingLevel!,
            trainingLocation: plan.trainingLocation!,
            trainingType: plan.trainingType!,
          ),
        ],
      ),
    );
  }

  Widget buildItemImage(
      {required String imageUrl,
      required String planId,
      required bool? isBookmarked,
      required Function isPressed,
      required int index}) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: EdgeInsets.only(top: 3),
          // height: MediaQuery.of(Get.context!).size.height / 3,
          width: MediaQuery.of(Get.context!).size.width,
          child: ImageMultiType(url:Constants.imageUrl + imageUrl,
              fit: BoxFit.fitWidth),
        ),
        isBookmarked == null
            ? SizedBox.shrink()
            : IconButton(
                onPressed: () {
                  // addToBookmark(planId, isBookmarked);
                  isPressed(index);
                },
                icon: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SvgPicture.asset('asset/Images/bookmarkSVG.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: SvgPicture.asset('asset/Images/star.svg',
                          color: isBookmarked ? Colors.blue : Colors.grey),
                    ),
                  ],
                ),
              )
      ],
    );
  }

  Widget buildItemInformation({
    required String planTitle,
    required Widget subTitle,
    required String trainerImageUrl,
    required String trainerName,
    required List<TrainingLocation> trainingLocation,
    required List<TrainingType> trainingType,
    required List<TrainingLevel> trainingLevel,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TrainerProfileImage(trainerImageUrl: trainerImageUrl),
            SizedBox(width: Get.width / 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      planTitle,
                      style: const TextStyle(
                        color: Color(0xff565C63),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    trainerName,
                    style: TextStyle(
                      color: Get.theme.colorScheme.secondary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subTitle,
                  SizedBox(
                    width: Get.width - 100,
                    height: Get.height / 20,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        Row(
                            children: trainingLocation
                                .map((e) => CustomChip(text: e.type!))
                                .toList()),
                        Row(
                            children: trainingLevel
                                .map((e) => CustomChip(text: e.type!))
                                .toList()),
                        Row(
                            children: trainingType
                                .map((e) => CustomChip(text: e.type!))
                                .toList()),

                        // CustomChip(text: trainingLocation),
                        // CustomChip(text: trainingLevel),
                        // CustomChip(text: trainingType),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
