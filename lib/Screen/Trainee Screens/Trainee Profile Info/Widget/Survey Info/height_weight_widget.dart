import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../trainee_text_field.dart';

class HeightWeightWidget extends GetWidget<TraineeProfileInfoController> {
  const HeightWeightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TraineeTextField(
          text: 'weight'.tr,
          controller: TextEditingController(
              text: controller.userProfile.fitnessSurvey == null
                  ? "0"
                  : controller.userProfile.fitnessSurvey!.weight!.toString()),
          onChange: (String value) {
            controller.userProfile.fitnessSurvey!.weight = int.parse(value);
          },
        )),
        Expanded(
            child: TraineeTextField(
          text: 'height'.tr,
          controller: TextEditingController(
              text: controller.userProfile.fitnessSurvey == null
                  ? "0"
                  : controller.userProfile.fitnessSurvey!.height!.toString()),
          onChange: (String value) {
            controller.userProfile.fitnessSurvey!.height = int.parse(value);
          },
        )),
      ],
    );
  }
}
