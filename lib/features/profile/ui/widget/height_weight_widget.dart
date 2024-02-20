
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/trainee_text_field.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../data/response/profile_response.dart';

class HeightWeightWidget extends StatefulWidget {
  const HeightWeightWidget({super.key});

  @override
  State<HeightWeightWidget> createState() => _HeightWeightWidgetState();
}

class _HeightWeightWidgetState extends State<HeightWeightWidget> {
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
    return Row(
      children: [
        Expanded(
            child: TraineeTextField(
          text: 'weight'.tr,
          controller:
              TextEditingController(text: request.fitnessSurvey.weight.toString()),
          onChange: (String value) => cubit.setWeight = int.tryParse(value),
        )),
        Expanded(
            child: TraineeTextField(
          text: 'height'.tr,
          controller:
              TextEditingController(text: request.fitnessSurvey.height.toString()),
          onChange: (String value) => cubit.setHeight = int.tryParse(value),
        )),
      ],
    );
  }
}
