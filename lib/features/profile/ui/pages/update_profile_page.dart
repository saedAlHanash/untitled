import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/features/auth/bloc/survey_cubit/survey_cubit.dart';
import 'package:fitness_storm/features/profile/ui/widget/survey_info_body.dart';
import 'package:fitness_storm/features/profile/ui/widget/trainee_edit_profile.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/profile_cubit/profile_cubit.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../../../Screen/Trainee Screens/Trainee_Profile/trainee_profile_controller.dart';
import '../widget/profile_details_body.dart';

class TraineeProfileInfoScreen extends StatelessWidget {
  const TraineeProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<ProfileCubit>().getProfile(newData: true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text('profile_info'.tr),
          titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<ProfileCubit, ProfileInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TraineeEditProfile(),
                    const ProfileDetailsBody(),
                    const SurveyInfoBody(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 10),
                        BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
                          builder: (context, state) {
                            if (state.statuses.loading) {
                              return MyStyle.loadingWidget();
                            }

                            return MaterialButton(
                              height: 40,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: Get.theme.primaryColor,
                              onPressed: () async {
                                context.read<UpdateProfileCubit>().updateProfile();
                              },
                              child: Text(
                                'edit_profile'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                        MaterialButton(
                          height: 40,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Colors.red,
                          onPressed: () async {
                            // await controller.deleteAccount();
                          },
                          child: Center(
                            child: Text(
                              'delete_account'.tr,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
