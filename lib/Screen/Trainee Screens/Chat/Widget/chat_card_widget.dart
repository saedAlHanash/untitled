import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/chat_controller.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:fitness_storm/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../main.dart';
import '../../../chat/chat.dart';
import '../../../chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
import '../../../chat/room_messages_bloc/room_messages_cubit.dart';
import '../../../chat/util.dart';

class ChatCardWidget extends StatefulWidget {
  const ChatCardWidget({
    super.key,
    required this.room,
  });

  final Room room;

  @override
  State<ChatCardWidget> createState() => _ChatCardWidgetState();
}

class _ChatCardWidgetState extends State<ChatCardWidget> {
  Future<void> openRoom(
    BuildContext context,
  ) async {
    roomMessage = await Hive.openBox<String>(widget.room.id);
    if (context.mounted) {
      context.read<GetRoomsCubit>().state.stream?.pause();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => RoomMessagesCubit()..getChatRoomMessage(widget.room),
              child: ChatPage(
                room: widget.room,
                name: getChatMember(widget.room.users).lastName ?? '',
              ),
            );
          },
        ),
      ).then((value) {
        roomMessage.close();
        context.read<GetRoomsCubit>().state.stream?.resume();
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openRoom(context),
      child: Container(
        height: Get.height / 9,
        width: Get.width,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: Get.height / 162.4),
        child: Row(children: [
          Container(
              width: Get.width / 6,
              height: Get.width / 6,
              margin: EdgeInsets.only(left: Get.width / 12.5, right: Get.width / 18.75),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 2, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 8,
                    offset: const Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: '',
                  fadeInDuration: const Duration(seconds: 1),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator.adaptive(),
                  errorWidget: (context, url, error) =>
                      Image.asset('asset/Images/user.png', fit: BoxFit.fill),
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getChatMember(widget.room.users).lastName ?? '',
                style: const TextStyle(
                    color: Color(0xFF565C63), fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.room.lastMessages?.first.status?.name ?? '',
                style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 16),
              ),
              const Divider(),
              DrawableText(
                  color: Colors.grey,
                  size: 12.0,
                  text: DateTime.fromMillisecondsSinceEpoch(
                          widget.room.updatedAt ?? DateTime.now().millisecond)
                      .formatDuration())
            ],
          ),
          if (widget.room.isNotReed) ...[
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.circle,
                color: Get.theme.primaryColor,
              ),
            )
          ]
        ]),
      ),
    );
  }
}

Future<void> openRoomFunction(BuildContext context, Room room) async {
  roomMessage = await Hive.openBox<String>(room.id);
  if (context.mounted) {
    context.read<GetRoomsCubit>().state.stream?.pause();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
            create: (context) => RoomMessagesCubit()..getChatRoomMessage(room),
            child: ChatPage(
              room: room,
              name: getChatMember(room.users).lastName ?? '',
            ),
          );
        },
      ),
    ).then((value) {
      roomMessage.close();
      context.read<GetRoomsCubit>().state.stream?.resume();
    });
  }
}
