import 'package:fitness_storm/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class TraineeTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? suffixText;
  final Function(String value) onChange;

  const TraineeTextField(
      {super.key,
      required this.text,
      required this.controller,
      this.suffixText,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 2),
          child: Text(text,
              style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 14)),
        ),
        Expanded(
          child: CustomTextField(
            '',
            controller: AppTextFieldController(false),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15)),
            textController: controller,
            style: const TextStyle(color: Color(0xFF565C63), fontSize: 14),
            isUnderline: true,
            suffixText: suffixText,
            onChanged: onChange,
          ),
        )
      ],
    );
  }
}
