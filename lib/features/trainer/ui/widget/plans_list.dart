import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Widgets/custom_chip.dart';
import '../../../../Widgets/trainer_profile_image.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../plans/bloc/add_favorite/add_favorite_cubit.dart';

class PlansList extends StatelessWidget {
  const PlansList({
    super.key,
    required this.plan,
    required this.subTitle,
    required this.index,
  });

  final PlanModel plan;
  final Widget subTitle;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.planOverview, arguments: plan.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _PlanImage(plan: plan),
          buildItemInformation(
            planTitle: plan.name,
            subTitle: subTitle,
            trainerImageUrl: plan.trainer!.image,
            trainerName: plan.trainer!.name,
            trainingLevel: plan.level,
            trainingLocation: plan.trainingLocation,
            trainingType: plan.trainingType,
          ),
        ],
      ),
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

class _PlanImage extends StatefulWidget {
  const _PlanImage({required this.plan});

  final PlanModel plan;

  @override
  State<_PlanImage> createState() => _PlanImageState();
}

class _PlanImageState extends State<_PlanImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 3),
          width: MediaQuery.of(Get.context!).size.width,
          child: ImageMultiType(
              url: widget.plan.image, fit: BoxFit.fitWidth),
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
      ],
    );
  }
}
