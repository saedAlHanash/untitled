import 'package:fitness_storm/Screen/Trainee%20Screens/Conversation/conversation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ConversationTextFeild extends GetWidget<ConversationController> {
  const ConversationTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 17,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
      margin: EdgeInsets.only(bottom: Get.height / 20.3, top: Get.height / 60),
      child: TextField(
        controller: controller.messageController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          focusColor: Colors.white,
          hintText: "Write a message",
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFD1D1D1)),
          suffixIcon: GestureDetector(
            onTap: controller.onSendMessage,
            child: Container(
              // width: Get.width / 10,
              margin: EdgeInsets.all(Get.height / 200),
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(500))),
              child: controller.isLoadingSend
                  ? const CircularProgressIndicator.adaptive()
                  : SvgPicture.asset(
                      'asset/Images/send.svg',
                      color: Colors.white,
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                    ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
      ),
    );
  }
}
