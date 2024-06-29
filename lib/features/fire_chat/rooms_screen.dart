import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/features/fire_chat/open_room_cubit/open_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../services/chat_service/chat_service_core.dart';
import '../../services/chat_service/core/firebase_chat_core.dart';
import 'chat.dart';
import 'chat_card_widget.dart';
import 'customer_service_card_widget.dart';
import 'get_chats_rooms_bloc/get_rooms_cubit.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('chat'.tr),
        titleTextStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: StreamBuilder<List<Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return ListTile(
              onTap: () async {
                context.read<OpenRoomCubit>().openRoomCustomerService();
              },
              leading: CircleImageWidget(
                url: Assets.imagesCallCenter,
                size: 40.0.r,
              ),
              title: DrawableText(text: S.of(context).support),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room = snapshot.data![index];
              loggerObject.w(room.users.toString());
              return ListTile(
                onTap: () async {
                  context.read<OpenRoomCubit>().openRoomByRoom(room);
                },
                leading: CircleImageWidget(
                  url: room.otherUser.imageUrl,
                  size: 40.0.r,
                ),
                title: DrawableText(text: room.otherUser.name),
                subtitle: room.lastMessages?.firstOrNull?.latestMessage(room),
                trailing: room.updatedAt == null
                    ? null
                    : DrawableText(
                        textAlign: TextAlign.center,
                        size: 12.0.sp,
                        color: Colors.grey,
                        text:
                            DateTime.fromMillisecondsSinceEpoch(room.updatedAt!)
                                .formatDateTimeVertical,
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
