import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../chat/chat.dart';
import '../../../chat/util.dart';

class TrainerButton extends StatelessWidget {
  const TrainerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 40),
      child: CustomButton(
        onTapFunction: () async{
          final room = await getRoomByUser('0');
          if (context.mounted) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ChatPage(
                  room: room!,
                  name: 'CUSTOMER SERVICE' ?? '',
                );
              },
            ));
          }
        },
        text: 'Join_us_as_a_Trainer'.tr,
        fontSize: 18,
        textColor: Colors.white,
        height: Get.height / 16.24,
        width: Get.width,
        padding: 0,
      ),
    );
  }
}
