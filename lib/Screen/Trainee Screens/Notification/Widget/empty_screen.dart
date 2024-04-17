import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Get.width / 12.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'did_not_have_notifications'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF565C63), fontSize: 14),
            ),
            CustomButton(
              onTapFunction: () => Get.back(),
              textColor: Colors.white,
              fontSize: 16,
              text: 'choose_a_plan'.tr,
            )
          ],
        ),
      ),
    );
  }
}
