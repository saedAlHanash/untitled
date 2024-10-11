import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../fire_chat/open_room_cubit/open_room_cubit.dart';

class TermAndConditionWidget extends StatelessWidget {
  const TermAndConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawableText(
            matchParent: true,
            text: S.of(context).doYouHaveAnyQuestionInYourMind,
            color: Colors.white,
            size: 18.0.sp,
            fontFamily: FontManager.bold.name,
          ),
          DrawableText(
            text: S.of(context).checkOur,
            color: Colors.white,
            drawablePadding: 10.0.w,
            drawableEnd: TextButton(
              onPressed: () => startPdf(AppProvider.systemParams.faq, S().faq),
              child: DrawableText(
                text: S.of(context).fAQs,
                style: TextStyle(
                  color: AppColorManager.mainColor,
                  fontSize: 18.0.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColorManager.mainColor,
                  fontWeight: FontWeight.normal,
                  fontFamily: FontManager.bold.name,
                ),
              ),
            ),
          ),
          DrawableText(
            text: S.of(context).orContactOur,
            color: Colors.white,
            drawablePadding: 10.0.w,
            drawableEnd: BlocBuilder<OpenRoomCubit, OpenRoomInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return TextButton(
                  onPressed: () {
                    context.read<OpenRoomCubit>().openRoomCustomerService();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                  child: DrawableText(
                    text: S.of(context).customerService,
                    style: TextStyle(
                      color: AppColorManager.mainColor,
                      fontSize: 18.0.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColorManager.mainColor,
                      fontWeight: FontWeight.normal,
                      fontFamily: FontManager.bold.name,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
