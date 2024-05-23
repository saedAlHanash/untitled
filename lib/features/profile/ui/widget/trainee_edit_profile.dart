import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/widgets/item_image_create.dart';
import 'package:fitness_storm/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';

class TraineeEditProfile extends StatefulWidget {
  const TraineeEditProfile({super.key});

  @override
  State<TraineeEditProfile> createState() => _TraineeEditProfileState();
}

class _TraineeEditProfileState extends State<TraineeEditProfile> {
  @override
  Widget build(BuildContext context) {
    final profile = AppProvider.profile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        30.0.verticalSpace,
        BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
          builder: (context, state) {
            return ItemImageCreate(
              image: state.request.avatarImage,
              onLoad: (bytes) {
                context.read<UpdateProfileCubit>().setAvatar = bytes;
                setState(() {});
              },
            );
          },
        ),
        10.0.verticalSpace,
        DrawableText(
          text: profile.name!.isEmpty ? profile.email! : profile.name!,
          color: AppColorManager.mainColor,
          size: 26.0.sp,
          fontFamily: FontManager.cairoBold.name,
        ),
        20.0.verticalSpace,
      ],
    );
  }
}
