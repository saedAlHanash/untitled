import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerInfoButton extends StatelessWidget {
  final String title;

  const TrainerInfoButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFF5F5F5)),
      padding: EdgeInsets.symmetric(
          vertical: Get.height / 60, horizontal: Get.width / 37.5),
      child: Center(
          child: Text(title,
              style: const TextStyle(color: Color(0xFF565C63), fontSize: 18))),
    );
  }
}
