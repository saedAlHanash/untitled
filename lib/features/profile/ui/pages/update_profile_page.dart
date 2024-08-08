import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:fitness_storm/core/widgets/select_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/item_image_create.dart';
import '../../../../core/widgets/title_with_dote.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../bloc/profile_cubit/profile_cubit.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../data/response/profile_response.dart';
import '../widget/training_goal_checkbox_body.dart';
import '../widget/training_level_checkbox_body.dart';
import '../widget/workout_location_checkbox_body.dart';

class TraineeProfileInfoScreen extends StatefulWidget {
  const TraineeProfileInfoScreen({super.key});

  @override
  State<TraineeProfileInfoScreen> createState() => _TraineeProfileInfoScreenState();
}

class _TraineeProfileInfoScreenState extends State<TraineeProfileInfoScreen> {
  late final UpdateProfileCubit cubit;
  late final Profile request;
  late final TextEditingController controller;

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    cubit = context.read<UpdateProfileCubit>();
    request = cubit.state.request;
    controller = TextEditingController(text: request.birthDate?.formatDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProfileCubit, UpdateProfileInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<ProfileCubit>().getProfile(newData: true);
          },
        ),
        BlocListener<DeleteAccountCubit, DeleteAccountInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {

          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).profileInfo),
        body: SingleChildScrollView(
          child: BlocBuilder<ProfileCubit, ProfileInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0).r,
                    child: ItemImageCreate(
                      image: cubit.state.request.avatarImage,
                      onLoad: (bytes) {
                        context.read<UpdateProfileCubit>().setAvatar = bytes;
                        setState(() {});
                      },
                    ),
                  ),
                  TitleWithDote(text: S.of(context).profileDetails),
                  10.0.verticalSpace,
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                      child: Column(
                        children: [
                          MyTextFormWidget(
                            initialValue: request.name,
                            color: AppColorManager.cardColor,
                            validator: (p0) => cubit.validateName,
                            textColor: Colors.black87,
                            label: S.of(context).fullName,
                            onChanged: (p0) => cubit.setName = p0,
                          ),
                          MyTextFormWidget(
                            initialValue: request.email,
                            color: AppColorManager.cardColor,
                            validator: (p0) => cubit.validateEmail,
                            textColor: Colors.black87,
                            label: S.of(context).email,
                            onChanged: (p0) => cubit.setEmail = p0,
                          ),
                          MyTextFormWidget(
                            initialValue: request.mobile,
                            color: AppColorManager.cardColor,
                            keyBordType: TextInputType.phone,
                            validator: (p0) => cubit.validatePhone,
                            textColor: Colors.black87,
                            label: S.of(context).phone,
                            onChanged: (p0) => cubit.setPhone = p0,
                          ),
                          SelectSingeDateWidget(
                            onSelect: (selected) {
                              cubit.setDate = selected;
                              if (selected == null) return;
                              controller.text = selected.formatDate;
                            },
                            child: MyTextFormWidget(
                              controller: controller,
                              color: AppColorManager.cardColor,
                              validator: (p0) => cubit.validateDate,
                              textColor: Colors.black87,
                              label: S.of(context).birthDate,
                              enable: false,
                              iconWidgetLift: const ImageMultiType(
                                url: Icons.date_range,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TitleWithDote(text: S.of(context).surveyInfo),
                  10.0.verticalSpace,
                  Form(
                    key: _formKey1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MyTextFormWidget(
                                  keyBordType: TextInputType.number,
                                  initialValue: request.fitnessSurvey.weight.toString(),
                                  validator: (p0) => cubit.validateWeight,
                                  color: AppColorManager.cardColor,
                                  textColor: Colors.black87,
                                  label: S.of(context).weight,
                                  onChanged: (p0) => cubit.setWeight = int.tryParse(p0),
                                ),
                              ),
                              15.0.horizontalSpace,
                              Expanded(
                                child: MyTextFormWidget(
                                  keyBordType: TextInputType.number,
                                  initialValue: request.fitnessSurvey.height.toString(),
                                  validator: (p0) => cubit.validateHeight,
                                  color: AppColorManager.cardColor,
                                  textColor: Colors.black87,
                                  label: S.of(context).height,
                                  onChanged: (p0) => cubit.setHeight = int.tryParse(p0),
                                ),
                              ),
                            ],
                          ),
                          10.0.verticalSpace,
                          MyTextFormWidget(
                            keyBordType: TextInputType.number,
                            initialValue: request.fitnessSurvey.dailyExercise.toString(),
                            validator: (p0) => cubit.validateHours,
                            color: AppColorManager.cardColor,
                            textColor: Colors.black87,
                            label: S.of(context).daysWeek,
                            onChanged: (p0) => cubit.setDailyExercise = int.tryParse(p0),
                          ),
                          MyTextFormWidget(
                            keyBordType: TextInputType.number,
                            initialValue: request.fitnessSurvey.weeklyExercise.toString(),
                            validator: (p0) => cubit.validateDays,
                            color: AppColorManager.cardColor,
                            textColor: Colors.black87,
                            label: S.of(context).hoursDay,
                            onChanged: (p0) => cubit.setWeeklyExercise = int.tryParse(p0),
                          ),
                          15.0.verticalSpace,
                          const WorkoutLocationCheckboxBody(),
                          const TrainingLevelCheckboxBody(),
                          const TrainingGoalCheckboxBody(),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        height: 45.0.h,
                        text: S.of(context).editProfile,
                        onTap: () async {
                          if (!_formKey.currentState!.validate()) return;
                          context.read<UpdateProfileCubit>().updateProfile();
                        },
                      );
                    },
                  ),
                  10.0.verticalSpace,
                  BlocBuilder<DeleteAccountCubit, DeleteAccountInitial>(
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        height: 45.0.h,
                        text: S.of(context).deleteAccount,
                        color: Colors.red,
                        textColor: Colors.white,
                        onTap: () async {
                          NoteMessage.showCheckDialog(
                            context,
                            text: S.of(context).areYouSure,
                            image: Icons.delete_forever,
                            textButton: S.of(context).deleteAccount,
                            onConfirm: (b) {
        if(!b)return;
                              context.read<DeleteAccountCubit>().deleteAccount(context);
                            },
                          );
                        },
                      );
                    },
                  ),
                  100.0.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
