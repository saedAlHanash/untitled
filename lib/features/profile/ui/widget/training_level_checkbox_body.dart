
import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/my_checkbox_widget.dart';
import 'package:fitness_storm/core/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../../../../features/profile/data/response/profile_response.dart';
import '../../../../../generated/l10n.dart';

class TrainingLevelCheckboxBody extends StatefulWidget {
  const TrainingLevelCheckboxBody({super.key});

  @override
  State<TrainingLevelCheckboxBody> createState() => _TrainingLevelCheckboxBodyState();
}

class _TrainingLevelCheckboxBodyState extends State<TrainingLevelCheckboxBody> {
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
          text: S.of(context).yourTrainingLevel,
          color: AppColorManager.a0,    matchParent: true,
        ),
        MyCheckboxWidget(
          items: [
            SpinnerItem(
              name: S.of(context).beginner,
              isSelected: request.fitnessSurvey.trainingLevelId == 'Beginner',
              item: 'Beginner',
            ),
            SpinnerItem(
              name: S.of(context).intermediate,
              isSelected: request.fitnessSurvey.trainingLevelId == 'Intermediate',
              item: 'Intermediate',
            ),
          ],
          onSelected: (value, index, isSelected) {
            request.fitnessSurvey.trainingLevelId = value.item;
          },
          isRadio: true,
        ),
        30.0.verticalSpace,
      ],
    );
  }
}
