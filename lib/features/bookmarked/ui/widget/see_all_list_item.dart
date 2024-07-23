import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/features/bookmarked/ui/widget/bookmarked_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Widgets/custom_chip.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';

class SeeAllListItem extends StatelessWidget {
  const SeeAllListItem({
    super.key,
    required this.plan,
  });

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        startPlanPage(plan.id.toString());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              ImageMultiType(
                url: plan.image,
                fit: BoxFit.fitWidth,
                height: 160.0.h,
                width: 1.0.sw,
              ),
              Align(
                alignment: Alignment.topRight,
                child: BookMarkedBtn(plan: plan),
              )
            ],
          ),
          10.0.verticalSpace,
          ListTile(
            leading: CircleImageWidget(
              url: plan.trainer.image,
              size: 70.0.r,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawableText(
                  text: plan.name,
                  fontFamily: FontManager.cairoBold.name,
                  fontWeight: FontWeight.bold,
                  size: 18.0.sp,
                ),
                DrawableText(
                  text: plan.trainer.name,
                  color: AppColorManager.mainColorLight,
                ),
                DrawableText(
                  text: '${plan.totalWeeks} ${S.of(context).weeks}',
                  color: Colors.grey,
                ),
              ],
            ),
            subtitle: SizedBox(
              width: 1.0.sw,
              height: 50.0.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  Row(
                      children: plan.trainingLocation
                          .map((e) => CustomChip(text: e.type))
                          .toList()),
                  Row(
                      children: plan.level
                          .map((e) => CustomChip(text: e.type))
                          .toList()),
                  Row(
                      children: plan.trainingType
                          .map((e) => CustomChip(text: e.type))
                          .toList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
