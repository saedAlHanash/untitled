import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../../Model/subscribed_plan.dart';
import '../../../../../generated/l10n.dart';

class ContinueTrainingWidget extends GetView<HomeScreenController> {
  const ContinueTrainingWidget({super.key});

  int _getNextDay(List<Days> days) {
    for (var element in days) {
      if (!element.completed!) {
        return element.dayNumber!;
      }
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final plans = controller.continueTrainingPlans.isNotEmpty
        ? controller.continueTrainingPlans
            .getRange(
                0,
                controller.continueTrainingPlans.length > 3
                    ? 3
                    : controller.continueTrainingPlans.length)
            .toList()
        : [];
    if (plans.isEmpty) return 0.0.verticalSpace;
    return Column(
      children: [
        DrawableText(
          text: S.of(context).continueTraining,
          color: AppColorManager.mainColor,
          matchParent: true,
          padding: const EdgeInsets.all(10.0).r,
          size: 18.0.sp,
          fontFamily: FontManager.cairoBold.name,
        ),
        SizedBox(
          width: 1.0.sw,
          height: 0.3.sh,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: plans.length,
            itemBuilder: (_, i) {
              final item = plans[i];
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.planOverview,
                    arguments: item.id,
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1.0.sw,
                      height: 0.2.sh,
                      child: Stack(
                        children: [
                          ImageMultiType(
                            url: item.image,
                            fit: BoxFit.cover,
                            width: 1.0.sw,
                          ),
                          Positioned(
                            top: 10.0.h,
                            left: 10.0.w,
                            child: Container(
                              padding: const EdgeInsets.all(5.0).r,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.black.withOpacity(0.6)),
                              child: DrawableText(
                                text:
                                    '${((item.userProgress ?? 0) * 100).round()}% ${'completed'.tr}',
                                size: 14.0.sp,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DrawableText(
                            fontWeight: FontWeight.bold,
                            text: item.name ?? '-',
                            color: AppColorManager.mainColorLight,
                          ),
                          DrawableText(
                            fontWeight: FontWeight.bold,
                            text:
                                '${'next_up'.tr} : Day ${_getNextDay(plans[i].days!)}',
                            color: AppColorManager.mainColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
