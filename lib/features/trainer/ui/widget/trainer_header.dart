import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/enum_manager.dart';
import '../../../../../core/widgets/my_button.dart';

import '../../../../Screen/Trainee Screens/Trainer Overview/Widget/ProfileBio/bio_check_widget.dart';
import '../../../../Screen/video/video.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Utils/utils.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../../../fire_chat/chat_card_widget.dart';
import '../../../fire_chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
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
            child: SizedBox(
              height: 160.0.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DrawableText(
                    text: (trainer.name).toUpperCase(),
                    size: 16.0.sp,
                    fontFamily: FontFamily.robotoBold.name,
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
                                child: MyButtonRound(
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
                                  onTap: () async {
                                    final openRoom = await context
                                        .read<RoomsCubit>()
                                        .getRoomByUser(trainer.id.toString());

                                    if (!context.mounted || openRoom == null) return;

                                    openRoomFunction(context, openRoom);
                                    return;
                                  },
                                ),
                              ),
                              15.0.horizontalSpace,
                              Expanded(
                                flex: 4,
                                child: MyButtonRound(
                                  color: AppColorManager.mainColorLight,
                                  enable: pair.second == PrivetSessionState.active,
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return Video1(appointment: pair.first!);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          if (pair.second == PrivetSessionState.waiting)
                            DrawableText(
                              padding: const EdgeInsets.symmetric(vertical: 5.0).h,
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
          ),
        ],
      ),
    );
  }

  void bookSession(TrainerModel trainer) {
    Utils.showAlertDialog(() {
      startBookPrivetSession(trainer);
    }, '''needBookPrivateSession'''.tr, textContinue: 'Book'.tr);
  }
}
