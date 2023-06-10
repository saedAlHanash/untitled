import 'package:fitness_storm/Model/chat.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/Widget/chat_card_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/Widget/customer_service_card_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/chat_controller.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text('chat'.tr),
          titleTextStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                color: Colors.white,
                onRefresh: () async {
                  await controller.getAllChats();
                },
                child: SingleChildScrollView(
                  child: Column(children: [
                    GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.conversationScreen,
                            arguments: ['customer_service'.tr, "-1"]),
                        child: const CustomerServiceCardwidget()),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.chats.length,
                      itemBuilder: (context, index) {
                        Chat chat = controller.chats[index];
                        return GestureDetector(
                            onTap: () => Get.toNamed(
                                    AppRoutes.conversationScreen,
                                    arguments: [
                                      chat.trainer!.name!,
                                      chat.channelId
                                    ]),
                            child: ChatCardWidget(
                                imagePath: chat.trainer!.image!,
                                trainerName: chat.trainer!.name!,
                                lastMessage: chat.lastMessage!.message!));
                      },
                    )
                  ]),
                ),
              ),
      ),
    );
  }
}
