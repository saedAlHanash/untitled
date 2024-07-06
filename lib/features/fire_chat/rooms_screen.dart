import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/features/fire_chat/open_room_cubit/open_room_cubit.dart';
import 'package:fitness_storm/features/fire_chat/rooms_bloc/rooms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../core/util/my_style.dart';
import '../../services/chat_service/core/firebase_chat_core.dart';

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
      body: BlocBuilder<RoomsCubit, RoomsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return ListView.builder(
            itemCount: state.result.length,
            itemBuilder: (context, index) {
              final room = state.result[index];

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
