import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../../../fire_chat/open_room_cubit/open_room_cubit.dart';
import '../../data/response/trainer.dart';

class TrainerHeader extends StatelessWidget {
  const TrainerHeader({super.key, required this.trainer});

  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0).r,
      child: Row(
        children: [
          SizedBox(
            height: 160.0.h,
            width: 120.0.w,
            child: RoundImageWidget(
              url: (trainer.image),
              radios: 12.0.r,
              height: 160.0.h,
              width: 120.0.w,
            ),
          ),
          10.0.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DrawableText(
                  text: (trainer.name).toUpperCase(),
                  size: 16.0.sp,
                  fontFamily: FontManager.bold.name,
                ),
                15.0.verticalSpace,
                RatingBarIndicator(
                  itemCount: 5,
                  rating: trainer.rating.toDouble(),
                  itemSize: 30.0.r,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 25.0.r,
                  ),
                ),
                15.0.verticalSpace,
                BioCheckWidget(
                    title: S.of(context).privateHours,
                    value: '+${trainer.numberOfPrivateHours}'),
                BlocBuilder<BookedAppointmentsCubit, BookedAppointmentsInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }

                    final pair = state.getSession();

                    if (pair.second == PrivetSessionState.noEver &&
                        !AppControl.isAppleAccount) {
                      return 0.0.verticalSpace;
                    }
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child:
                                  BlocBuilder<OpenRoomCubit, OpenRoomInitial>(
                                builder: (context, state) {
                                  if (state.statuses.loading) {
                                    return MyStyle.loadingWidget();
                                  }
                                  return MyButtonRound(
                                    color: AppColorManager.mainColor,
                                    child: DrawableText(
                                      text: S.of(context).chat,
                                      drawablePadding: 3.0.w,
                                      drawableEnd: ImageMultiType(
                                        url: Assets.imagesChatSVG,
                                        height: 15.0.w,
                                        width: 15.0.w,
                                        color: Colors.white,
                                      ),
                                      size: 14.0.sp,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      context
                                          .read<OpenRoomCubit>()
                                          .openRoomByUserId(
                                            trainer.id.toString(),
                                            trainer: trainer,
                                          );
                                    },
                                  );
                                },
                              ),
                            ),
                            15.0.horizontalSpace,
                            Expanded(
                              flex: 4,
                              child: MyButtonRound(
                                color: AppColorManager.secondColor,
                                enable:
                                    pair.second == PrivetSessionState.active,
                                child: DrawableText(
                                  text: S.of(context).videoCall,
                                  color: Colors.white,
                                  size: 14.0.sp,
                                  drawablePadding: 3.0.w,
                                  drawableEnd: ImageMultiType(
                                    url: Assets.imagesVideo,
                                    height: 15.0.w,
                                    width: 15.0.w,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  if (pair.first!.videoCallToken.isEmpty) {
                                    context
                                        .read<BookedAppointmentsCubit>()
                                        .getBookedAppointments();
                                    return;
                                  }

                                  startVideoCall(pair.first!);
                                },
                              ),
                            ),
                          ],
                        ),
                        if (pair.second == PrivetSessionState.waiting)
                          DrawableText(
                            padding:
                                const EdgeInsets.symmetric(vertical: 5.0).h,
                            text:
                                '${S.of(context).nextSession}: ${pair.first?.startTime.formatDateTime}',
                            size: 12.0.sp,
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

class BioCheckWidget extends StatelessWidget {
  const BioCheckWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 7.0.w,
      leading: ImageMultiType(
        color: AppColorManager.mainColor,
        url: Icons.check_circle_outline_sharp,
        height: 35.0.r,
        width: 35.0.r,
      ),
      title: DrawableText(
        text: title,
        color: AppColorManager.black,
        size: 10.0.sp,
      ),
      subtitle: DrawableText(
        text: value,
        color: AppColorManager.mainColor,
        fontWeight: FontWeight.bold,
        size: 25.0.sp,
      ),
    );
  }
}
