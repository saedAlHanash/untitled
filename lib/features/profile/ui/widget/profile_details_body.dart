import 'package:fitness_storm/core/widgets/trainee_text_field.dart';
import 'package:fitness_storm/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/response/profile_response.dart';

class ProfileDetailsBody extends StatefulWidget {
  const ProfileDetailsBody({super.key});

  @override
  State<ProfileDetailsBody> createState() => _ProfileDetailsBodyState();
}

class _ProfileDetailsBodyState extends State<ProfileDetailsBody> {
  late final UpdateProfileCubit cubit;
  late final Profile request;

  @override
  void initState() {
    cubit = context.read<UpdateProfileCubit>();
    request = cubit.state.request;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 12),
          child: Column(
            children: [
              TraineeTextField(
                text: 'full_name'.tr,
                controller: TextEditingController(text: request.name),
                onChange: (String value) {
                  cubit.setName = value;
                },
              ),
              TraineeTextField(
                text: 'email'.tr,
                controller: TextEditingController(text: request.email),
                onChange: (String value) {
                  cubit.setEmail = value;
                },
              ),
              TraineeTextField(
                text: 'Mobile'.tr,
                controller: TextEditingController(text: request.mobile),
                onChange: (String value) {
                  cubit.setPhone = value;
                },
              ),
              // const GenderCheckboxBody(),
              // const BirthdayDateBody()
            ],
          ),
        )
      ],
    );
  }
}
