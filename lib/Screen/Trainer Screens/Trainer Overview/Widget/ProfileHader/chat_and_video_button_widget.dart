import 'package:fitness_storm/Model/chat.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/chat_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Conversation/conversation_controller.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Utils/Routes/app_pages.dart';
import '../../../../video/video.dart';
import '../../../Trainer Calender/trainer_calender_controller.dart';

// ignore: must_be_immutable
class ChatAndVideoButtonWidget extends StatefulWidget {
  ChatAndVideoButtonWidget({super.key, required this.trainerName});

  String trainerName;

  @override
  State<ChatAndVideoButtonWidget> createState() =>
      _ChatAndVideoButtonWidgetState();
}

class _ChatAndVideoButtonWidgetState extends State<ChatAndVideoButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            bool check = await Get.put(TrainerCalenderController())
                .chatIsAvailable(widget.trainerName);

            if (!check) {
              // Utils.showAlertDialog(onContinueButtonPressed, message)
              Utils.showAlertDialog(() {
                Get.back();
              }, "make_chat");
            } else {
              Utils.openLoadingDialog();
              List<Chat> chats = await Get.put(ChatController()).getChats();
              var chat = chats.firstWhere(
                  (element) => element.trainer!.name == widget.trainerName);

              String channelId = chat.channelId!;
              try {
                await Get.put(ConversationController())
                    .onSendMessage(channelId: channelId);
                Get.toNamed(
                  AppRoutes.conversationScreen,
                  arguments: [widget.trainerName, channelId],
                );
                Utils.closeDialog();
              } catch (e) {
                Utils.closeDialog();
                Utils.openSnackBar(title: e.toString());
              }
            }
          },
          child: Container(
            height: Get.height / 27,
            width: Get.width / 12.5,
            // padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Get.theme.colorScheme.secondary,
            ),
            child: Image.asset(
              'asset/Images/chat3.png',
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () async {
            var data = await Get.put(TrainerCalenderController())
                .traineeMakeVideoCall();
            if (data != null) {
              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Video1(
                            tempToken: data,
                          )));
            } else {
              Utils.openSnackBar(message: "It's not time for the call yet");
            }
          },
          child: Container(
            height: Get.height / 27,
            // width: Get.width / 2.5,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Get.theme.colorScheme.secondary,
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 3),
                Image.asset(
                  'asset/Images/video.png',
                ),
                const SizedBox(width: 5),
                Text(
                  'private_session'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
