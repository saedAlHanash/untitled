import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/util/snack_bar_message.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/features/appointments/data/response/bundles_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../appointments/bloc/available_times_cubit/available_times_cubit.dart';
import '../../../appointments/bloc/bundles_cubit/bundles_cubit.dart';
import '../../data/response/trainer.dart';

class TrainerBioWidget extends StatelessWidget {
  const TrainerBioWidget({required this.trainer, super.key});

  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.0.sw,
          color: AppColorManager.mainColor,
          padding: const EdgeInsets.all(10.0).r,
          child: BlocBuilder<AvailableTimesCubit, AvailableTimesInitial>(
            builder: (context, timesState) {
              if (timesState.statuses.loading) {
                return MyStyle.loadingWidget(color: Colors.white);
              }

              if (timesState.result.isEmpty) {
                return Column(
                  children: [
                    DrawableText(
                      text: S.of(context).oops,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                    DrawableText(
                      text: S.of(context).fullyBooked,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                    10.0.verticalSpace,
                    MyButton(
                      onTap: () {
                        NoteMessage.showSuccessSnackBar(
                            message: 'Done', context: context);
                      },
                      color: Colors.white,
                      radios: 2.0.r,
                      height: 35.0.h,
                      child: DrawableText(
                        text: S.of(context).noteMe,
                        color: AppColorManager.mainColor,
                        drawablePadding: 10.0.w,
                        size: 12.0.sp,
                        drawableStart: ImageMultiType(
                          url: Assets.imagesNoteMe,
                          height: 20.0.r,
                          width: 20.0.r,
                        ),
                      ),
                    )
                  ],
                );
              }
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      // if (AppControl.isAppleAccount) return;
                      // startBookPrivetSession(trainer);
                    },
                    child: Row(
                      children: [
                        DrawableText(
                          text:
                              '${S.of(context).availableSession} (${timesState.result.length})',
                          size: 14.0.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  // const Divider(color: Colors.white),
                  BlocBuilder<BundlesCubit, BundlesInitial>(
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget(color: Colors.white);
                      }
                      if (state.result.isEmpty) {
                        return 0.0.verticalSpace;
                      }
                      return SizedBox(
                        height: 130.0.h,
                        width: 1.0.sw,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.result.length,
                          itemBuilder: (_, i) => _BundleItem(
                            item: state.result[i],
                            maxTimesCount: timesState.result.length,
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
        Container(
          color: AppColorManager.topBarColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0).r,
          child: DrawableText(
            text: trainer.bio,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: FontManager.cairoBold.name,
            size: 16.0.sp,
            matchParent: true,
            textAlign: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0).r,
          ),
        ),
      ],
    );
  }
}

class _BundleItem extends StatelessWidget {
  const _BundleItem({
    required this.item,
    required this.maxTimesCount,
  });

  final Bundle item;
  final int maxTimesCount;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: item.sessions > maxTimesCount ? 0.7 : 1,
      child: InkWell(
        onTap: item.sessions > maxTimesCount ? null : () => startCreateBundle(item),
        child: Container(
          width: 99.0.r,
          margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0).r,
          padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0.r),
            boxShadow: [
              BoxShadow(
                color: AppColorManager.lightGray,
                spreadRadius: 3.0.r,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DrawableText(
                text: item.name,
                size: 11.0.sp,
                maxLines: 2,
                color: AppColorManager.mainColor,
              ),
              DrawableText(
                text: '${item.price} ${S.of(context).sar}',
                fontWeight: FontWeight.bold,
                maxLines: 2,
                textAlign: TextAlign.center,
                color: AppColorManager.mainColor,
              ),
              DrawableText(
                text: '${item.sessions} ${S.of(context).session}',
                size: 10.0.sp,
                maxLines: 1,
                color: AppColorManager.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
