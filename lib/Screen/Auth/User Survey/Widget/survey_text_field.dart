import 'package:fitness_storm/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyTextField extends StatelessWidget {
  const SurveyTextField(
      {super.key,
      required this.textEditingController,
      required this.title,
      required this.suffix,
      required this.hint});

  final String hint;
  final String suffix;
  final TextEditingController textEditingController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.white)),
        CustomTextField(
          '',
          controller: AppTextFieldController(false),
          textController: textEditingController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 8.0, top: Get.height / 60),
            child: Text(
              suffix,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
