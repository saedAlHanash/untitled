import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/my_checkbox_widget.dart';
import 'package:fitness_storm/core/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../data/response/profile_response.dart';

class TrainingGoalCheckboxBody extends StatefulWidget {
  const TrainingGoalCheckboxBody({super.key});

  @override
  State<TrainingGoalCheckboxBody> createState() => _TrainingGoalCheckboxBodyState();
}

class _TrainingGoalCheckboxBodyState extends State<TrainingGoalCheckboxBody> {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawableText(
          text: S.of(context).yourTrainingGoal,
          color: AppColorManager.a0,
          matchParent: true,
        ),
        MyCheckboxWidget(
          items: [
            SpinnerItem(
              name: S.of(context).loseWeight,
              isSelected: request.fitnessSurvey.trainingGoal == 'Lose weight',
              item: 'Lose weight',
            ),
            SpinnerItem(
              name: S.of(context).buildMuscle,
              isSelected: request.fitnessSurvey.trainingGoal == 'Build muscle',
              item: 'Build muscle',
            ),
            SpinnerItem(
              name: S.of(context).stayFit,
              isSelected: request.fitnessSurvey.trainingGoal == 'Stay fit',
              item: 'Stay fit',
            ),
          ],
          onSelected: (value, index, isSelected) {
            request.fitnessSurvey.trainingGoal = value.item;
          },
          isRadio: true,
        ),
        30.0.verticalSpace,
      ],
    );
  }
}
