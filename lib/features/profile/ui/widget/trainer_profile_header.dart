import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/enum_manager.dart';
import '../../../../../core/widgets/my_button.dart';

import '../../../../Screen/video/video.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Utils/utils.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../../../fire_chat/chat_card_widget.dart';
import '../../../fire_chat/get_chats_rooms_bloc/get_rooms_cubit.dart';

class TrainerProfileHeader extends StatefulWidget {
  const TrainerProfileHeader({super.key});

  @override
  State<TrainerProfileHeader> createState() => _TrainerProfileHeaderState();
}

class _TrainerProfileHeaderState extends State<TrainerProfileHeader> {
  final trainer = TrainerModel.fromProfile();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawableText(
                  text: (trainer.name).toUpperCase(),
                  size: 16.0.sp,
                  fontFamily: FontFamily.robotoBold.name,
                ),
                30.0.verticalSpace,
                if(trainer.agreement.isNotEmpty)
                Center(
                  child: MyButton(
                    onTap: () {
                      //loggerObject.w(trainer.agreement);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBarWidget(
                                titleText: S.of(context).agreement,
                              ),
                              body: ImageMultiType(
                                url: trainer.agreement,
                                height: 1.0.sh,
                                width: 1.0.sw,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    text: 'show agreement',
                    height: 40.0.h,
                    width: 0.5.sw,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
