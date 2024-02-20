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

import '../../../../Screen/Trainee Screens/Chat/Widget/chat_card_widget.dart';
import '../../../../Screen/chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
import '../../../../Utils/Routes/app_pages.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/bloc/logout/logout_cubit.dart';
import '../../bloc/profile_cubit/profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(zeroHeight: true),
      body: BlocBuilder<ProfileCubit, ProfileInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 100.0).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.0.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColorManager.gray.withOpacity(0.5),
                        blurRadius: 10.0,
                        offset: Offset(0, 7.h),
                      ),
                    ],
                  ),
                  child: CircleImageWidget(
                    url: Assets.imagesUser,
                    size: 100.0.r,
                  ),
                ),
                10.0.verticalSpace,
                DrawableText(
                  text: state.result.name!.isEmpty
                      ? state.result.email!
                      : state.result.name!,
                  color: AppColorManager.mainColor,
                  size: 26.0.sp,
                  fontFamily: FontManager.cairoBold.name,
                ),
                20.0.verticalSpace,
                const _ProfileCards(),
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
                BlocBuilder<GetRoomsCubit, GetRoomsInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      onTap: () async {
                        final room =
                            await context.read<GetRoomsCubit>().getRoomByUser('0');

                        if (context.mounted) {
                          openRoomFunction(context, room!);
                        }
                      },
                      text: S.of(context).JoinUsAsATrainer,
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
          );
        },
      ),
    );
  }
}

class _ProfileCards extends StatelessWidget {
  const _ProfileCards();

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
        const ProfileCard(type: ProfileCardType.appointment)
      ],
    );
  }
}
