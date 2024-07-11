import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomChip extends StatelessWidget {
  final String text;

  const CustomChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          color: Get.theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(left: Get.width / 90, right: Get.width / 90),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          )),
      // labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
      // backgroundColor: Get.theme.colorScheme.secondary,
    );
  }
}
