import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/Widget/chat_card_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/Widget/customer_service_card_widget.dart';
import 'package:fitness_storm/Screen/chat/util.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';

import '../../chat/chat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('chat'.tr),
        titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: StatefulBuilder(builder: (context, state) {
        return FutureBuilder(
          future: getChatRooms(),
          builder: (context, AsyncSnapshot<List<Room>?> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return RefreshIndicator(
              color: Colors.white,
              onRefresh: () async {
                state(() {});
              },
              child: SingleChildScrollView(
                child: Column(children: [
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.conversationScreen,
                        arguments: ['customer_service'.tr, "-1"]),
                    child: const CustomerServiceCardwidget(),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final openRoom = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChatPage(
                                room: openRoom,
                                name: getChatMember(openRoom.users).lastName ?? '',
                              );
                            },
                          ));
                          // Get.toNamed(AppRoutes.conversationScreen,
                          //   arguments: [chat.trainer!.name!, chat.channelId]);
                        },
                        child: ChatCardWidget(
                          imagePath: '',
                          trainerName: getChatMember(openRoom.users).lastName ?? '',
                          lastMessage: openRoom.lastMessages?.first.status?.name ?? '',
                        ),
                      );
                    },
                  )
                ]),
              ),
            );
          },
        );
      }),
    );
  }
}
