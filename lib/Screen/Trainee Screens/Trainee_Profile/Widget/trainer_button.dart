import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../chat/chat.dart';
import '../../../chat/util.dart';
import '../../Chat/Widget/chat_card_widget.dart';

class TrainerButton extends StatefulWidget {
  const TrainerButton({super.key});

  @override
  State<TrainerButton> createState() => _TrainerButtonState();
}

class _TrainerButtonState extends State<TrainerButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 40),
      child: CustomButton(
        onTapFunction: () async{
                  if (loading) return;
                        loading = true;
          final room = await getRoomByUser('0');
           loading = false;
          if (context.mounted) {
            openRoomFunction(context, room!);
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
