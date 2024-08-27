import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/features/profile/ui/widget/card_profile.dart';
import 'package:fitness_storm/features/profile/ui/widget/user_profile_info_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/bloc/logout/logout_cubit.dart';
import '../../../fire_chat/open_room_cubit/open_room_cubit.dart';
import '../../bloc/profile_cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(zeroHeight: true),
      body: BlocBuilder<ProfileCubit, ProfileInitial>(
        builder: (context, state) {
          final profile = state.result;
          return RefreshWidget(
            onRefresh: () {
              context.read<ProfileCubit>().getProfile(newData: true);
            },
            isLoading: state.statuses.loading,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 100.0).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  30.0.verticalSpace,
                  CircleImageWidget(
                    url:
                        (profile.image ?? '').isEmpty ? Assets.imagesUser : profile.image,
                    size: 100.0.r,
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    text: profile.name!.isEmpty ? profile.email! : profile.name!,
                    color: AppColorManager.mainColor,
                    size: 26.0.sp,
                    fontFamily: FontManager.cairoBold.name,
                  ),
                  20.0.verticalSpace,
                  const ProfileCards(),
                  20.0.verticalSpace,
                  if (!AppControl.isAppleAccount) ...[
                    MyButton(
                      onTap: () => Get.toNamed(AppRoutes.subscriptionScreen),
                      child: DrawableText(
                        text: S.of(context).subscriptionPlans,
                        fontFamily: FontManager.cairoBold.name,
                        size: 15.0.sp,
                        color: Colors.white,
                        drawablePadding: 10.0.w,
                        drawableStart:
                            const ImageMultiType(url: Assets.imagesSubscription),
                      ),
                    ),
                    15.0.verticalSpace,
                  ],
                  BlocBuilder<OpenRoomCubit, OpenRoomInitial>(
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        onTap: () {
                          context.read<OpenRoomCubit>().openRoomCustomerService();
                        },
                        text: S.of(context).joinUsAsATrainer,
                        color: AppColorManager.mainColorLight,
                      );
                    },
                  ),
                  20.0.verticalSpace,
                  const UserProfileInfoButtons(),
                  20.0.verticalSpace,
                  BlocBuilder<LogoutCubit, LogoutInitial>(
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return TextButton(
                        onPressed: () => context.read<LogoutCubit>().logout(),
                        child: DrawableText(
                          text: S.of(context).logout,
                          color: Colors.grey,
                          drawablePadding: 10.0.w,
                          drawableEnd: const ImageMultiType(url: Assets.imagesLogout),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileCards extends StatelessWidget {
  const ProfileCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: ProfileCard(type: ProfileCardType.profile)),
            15.0.horizontalSpace,
            const Expanded(child: ProfileCard(type: ProfileCardType.fav)),
          ],
        ),
        25.0.verticalSpace,
        Row(
          children: [
            if (!AppControl.isAppleAccount)
              const Expanded(child: ProfileCard(type: ProfileCardType.payment)),
            if (!AppControl.isAppleAccount) 15.0.horizontalSpace,
            const Expanded(child: ProfileCard(type: ProfileCardType.lang)),
          ],
        ),
        25.0.verticalSpace,
        if (!AppControl.isAppleAccount)
          Row(
            children: [
              const Expanded(child: ProfileCard(type: ProfileCardType.appointment)),
              15.0.horizontalSpace,
              const Expanded(child: ProfileCard(type: ProfileCardType.diets)),
            ],
          ),
      ],
    );
  }
}
