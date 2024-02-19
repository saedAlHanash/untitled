
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../data/response/profile_response.dart';
import '../../../../core/widgets/trainee_text_field.dart';

class OftenExerciseWidget extends StatefulWidget {
  const OftenExerciseWidget({super.key});

  @override
  State<OftenExerciseWidget> createState() => _OftenExerciseWidgetState();
}

class _OftenExerciseWidgetState extends State<OftenExerciseWidget> {
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
        Text('you_often_exercise'.tr,
            style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 14)),
        TraineeTextField(
          text: '',
          controller: TextEditingController(
              text: request.fitnessSurvey.dailyExercise.toString()),
          suffixText: 'days/week'.tr,
          onChange: (String value) => cubit.setDailyExercise = int.tryParse(value),
        ),
        TraineeTextField(
          text: '',
          controller: TextEditingController(
              text: request.fitnessSurvey.weeklyExercise.toString()),
          suffixText: 'Hours/Day'.tr,
          onChange: (String value) => cubit.setWeeklyExercise = int.tryParse(value),
        ),
      ],
    );
  }
}
