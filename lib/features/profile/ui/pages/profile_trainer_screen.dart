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
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/bloc/logout/logout_cubit.dart';
import '../../bloc/profile_cubit/profile_cubit.dart';

class ProfileTrainerScreen extends StatefulWidget {
  const ProfileTrainerScreen({super.key});

  @override
  State<ProfileTrainerScreen> createState() => _ProfileTrainerScreenState();
}

class _ProfileTrainerScreenState extends State<ProfileTrainerScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppBarWidget(zeroHeight: true),
      body: BlocBuilder<ProfileCubit, ProfileInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }

          return RefreshIndicator(
            onRefresh: () async => context.read<ProfileCubit>().getProfile(newData: true),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  40.0.verticalSpace,
                  CircleImageWidget(
                    url: state.result.image,
                    size: 100.0.r,
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    text: state.result.name!,
                    color: AppColorManager.mainColor,
                    size: 26.0.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontManager.cairoBold.name,
                  ),
                  20.0.verticalSpace,
                  const _ProfileCards(),
                  20.0.verticalSpace,
                  MyButton(
                    onTap: () => Get.toNamed(AppRoutes.trainerPlans),
                    child: DrawableText(
                      text: S.of(context).myPlans,
                      fontFamily: FontManager.cairoBold.name,
                      size: 15.0.sp,
                      color: Colors.white,
                      drawablePadding: 10.0.w,
                      drawableStart: const ImageMultiType(url: Assets.imagesSubscription),
                    ),
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
            const Expanded(child: ProfileCard(type: ProfileCardType.lang)),
          ],
        ),
      ],
    );
  }
}
