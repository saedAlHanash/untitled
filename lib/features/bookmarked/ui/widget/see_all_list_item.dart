import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/features/bookmarked/ui/widget/bookmarked_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';

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
              RoundImageWidget(
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
          SizedBox(
            width: 1.0.sw,
            child: ListTile(
              leading: RoundImageWidget(
                url: plan.trainer.image,
                radios: 200.0,
                height: 50.0.r,
                width: 50.0.r,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawableText(
                    text: plan.name,
                    fontFamily: FontManager.bold.name,
                    fontWeight: FontWeight.bold,
                    size: 18.0.sp,
                  ),
                  DrawableText(
                    text: plan.trainer.name,
                    color: AppColorManager.secondColor,
                  ),
                  DrawableText(
                    text: '${plan.totalWeeks} ${S.of(context).weeks}',
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}
