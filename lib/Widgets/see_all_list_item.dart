import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../Utils/Routes/app_pages.dart';
import '../core/models/plan_model.dart';
import '../core/util/my_style.dart';
import '../features/plans/bloc/add_favorite/add_favorite_cubit.dart';
import '../generated/assets.dart';
import 'custom_chip.dart';
import 'trainer_profile_image.dart';

class SeeAllListItem extends StatefulWidget {
  final PlanModel plan;
  final Widget subTitle;
  final Function isPressed;
  final int index;

  const SeeAllListItem({
    super.key,
    required this.plan,
    required this.subTitle,
    required this.isPressed,
    required this.index,
  });

  @override
  State<SeeAllListItem> createState() => _SeeAllListItemState();
}

class _SeeAllListItemState extends State<SeeAllListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.planOverview, arguments: widget.plan.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildItemImage(
            imageUrl: widget.plan.image,
            planId: widget.plan.id,
            isBookmarked: widget.plan.isBookmark,
            isPressed: widget.isPressed,
            index: widget.index,
          ),
          buildItemInformation(
            planTitle: widget.plan.name,
            subTitle: widget.subTitle,
            trainerImageUrl: widget.plan.trainer.image,
            trainerName: widget.plan.trainer.name,
            trainingLevel: widget.plan.level,
            trainingLocation: widget.plan.trainingLocation,
            trainingType: widget.plan.trainingType,
          ),
        ],
      ),
    );
  }

  Widget buildItemImage(
      {required String imageUrl,
      required int planId,
      required bool isBookmarked,
      required Function isPressed,
      required int index}) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: EdgeInsets.only(top: 3),
          // height: MediaQuery.of(Get.context!).size.height / 3,
          width: MediaQuery.of(Get.context!).size.width,
          child: ImageMultiType(url: imageUrl, fit: BoxFit.fitWidth),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            height: 50.0.r,
            width: 50.0.r,
            child: BlocConsumer<AddFavoriteCubit, AddFavoriteInitial>(
              listenWhen: (p, c) => (c.plan.id == widget.plan.id) && (c.statuses.done),
              listener: (context, state) {
                setState(() => widget.plan.isBookmark = !widget.plan.isBookmark);
              },
              buildWhen: (p, c) => c.plan.id == widget.plan.id,
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return IconButton(
                  onPressed: () {
                    context.read<AddFavoriteCubit>().changeFavorite(plan: widget.plan);
                  },
                  icon: ImageMultiType(
                    url: state.plan.isBookmark
                        ? Assets.imagesActiveFav
                        : Assets.imagesBookmark,
                    height: 30.0.r,
                    width: 30.0.r,
                  ),
                );
              },
            ),
          ),
        )
/*        isBookmarked == null
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
              )*/
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
                                .map((e) => CustomChip(text: e.type))
                                .toList()),
                        Row(
                            children: trainingLevel
                                .map((e) => CustomChip(text: e.type))
                                .toList()),
                        Row(
                            children: trainingType
                                .map((e) => CustomChip(text: e.type))
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
