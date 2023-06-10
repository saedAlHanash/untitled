import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee%20Profile%20Info/trainee_profile_info_controller.dart';
import 'package:fitness_storm/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BirthdayDateBody extends GetWidget<TraineeProfileInfoController> {
  const BirthdayDateBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text('birthday'.tr,
                style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 16))),
        Expanded(
          flex: 4,
          child: CustomTextField(
            '',
            controller: AppTextFieldController(false),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15)),
            textController: controller.dateinput,
            style: const TextStyle(color: Color(0xFF565C63), fontSize: 16),
            isUnderline: true,
            suffixIcon: const Icon(Icons.date_range),
            onTap: controller.onDatePickerTap,
          ),
        )
      ],
    );
  }
}
