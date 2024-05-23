import 'dart:convert';

import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/features/fire_chat/chat.dart';
import 'package:fitness_storm/features/fire_chat/room_messages_bloc/room_messages_cubit.dart';
import 'package:fitness_storm/features/fire_chat/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../main.dart';
import 'get_chats_rooms_bloc/get_rooms_cubit.dart';

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
  Future<void> openRoom(BuildContext context) async {
    if (context.mounted) {
      openRoomFunction(context, widget.room).then((value) => setState(() {}));
    }
  }

  Widget get latestMessage {
    final json = latestMessagesBox.get(widget.room.id) ?? '{}';

    if (json == '{}') {
      return const SizedBox();
    }

    final message = Message.fromJson(jsonDecode(json));
    switch (message.type) {
      case MessageType.file:
        return const DrawableText(
          text: 'ملف',
          drawableEnd: ImageMultiType(url: Icons.file_copy),
        );
      case MessageType.image:
        return const DrawableText(
          text: 'صورة',
          drawableEnd: ImageMultiType(url: Icons.image),
        );
      case MessageType.video:
        return const DrawableText(
          text: 'فيديو',
          drawableEnd: ImageMultiType(url: Icons.videocam_rounded),
        );
      case MessageType.text:
        return DrawableText(
          text: (message as TextMessage).text,
          maxLines: 1,
          size: 12.sp,
          color: Colors.grey,
        );
      case MessageType.audio:
      case MessageType.custom:
      case MessageType.system:
      case MessageType.unsupported:
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    if (getChatMember(widget.room.users, me: false).firstName == '0') {
      return 0.0.verticalSpace;
    }
    return ListTile(
      onTap: () => openRoom(context),
      horizontalTitleGap: 15,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0).r,
      title: Text(
        getChatMember(widget.room.users).lastName ?? '',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: CircleImageWidget(
        size: 50.0.r,
        url: getChatMember(widget.room.users).imageUrl,
      ),
      subtitle: latestMessage,
      trailing: SizedBox(
        width: Get.width / 4.2,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    final date = DateTime.fromMillisecondsSinceEpoch(
                      widget.room.updatedAt ?? DateTime.now().millisecond,
                    );
                    var dateDuration =date.getFormat();
                    String text = '';
                    if (dateDuration.days <= 0) {
                      text = date.formatTime;
                    }else{
                      text = date.formatDate;
                    }
                    return Text(
                      text,
                      style: TextStyle(
                        color: const Color(0xff8E8E93),
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }),
                  if (widget.room.isNotReed)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
                      child: Icon(
                        Icons.circle,
                        size: 22.0.r,
                        color: AppColorManager.mainColor,
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            ImageMultiType(
              url: Icons.arrow_forward_ios_outlined,
              height: 12.0.r,
              width: 12.0.r,
              color: Colors.grey.withOpacity(0.3),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> openRoomFunction(BuildContext context, Room room) async {
  messageBox = await Hive.openBox<String>(room.id);

  if (context.mounted) {
    context.read<RoomsCubit>().state.stream?.pause();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
            create: (context) => MessagesCubit()..getChatRoomMessage(room),
            child: ChatPage(
              room: room,
              name: getChatMember(room.users).lastName ?? '',
            ),
          );
        },
      ),
    ).then((value) {
      messageBox.close();
      context.read<RoomsCubit>().state.stream?.resume();
    });
  }
}
