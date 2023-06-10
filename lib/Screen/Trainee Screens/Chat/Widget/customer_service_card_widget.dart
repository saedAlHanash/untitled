import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerServiceCardwidget extends GetWidget<ChatController> {
  const CustomerServiceCardwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 9,
      width: Get.width,
      color: Colors.white,
      child: Row(children: [
        Container(
          width: Get.width / 6,
          height: Get.width / 6,
          margin:
              EdgeInsets.only(left: Get.width / 12.5, right: Get.width / 18.75),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2, color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 8,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset('asset/Images/user.png')),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'customer_service'.tr,
              style: TextStyle(
                  color: Color(0xFF565C63),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'last_message'.tr,
              style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 16),
            )
          ],
        )
      ]),
    );
  }
}
