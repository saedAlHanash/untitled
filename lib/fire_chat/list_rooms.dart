import 'dart:async';

import 'package:chat_web_app/api_manager/api_service.dart';
import 'package:chat_web_app/fire_chat/chat.dart';
import 'package:chat_web_app/fire_chat/messages_bloc/messages_cubit.dart';
import 'package:chat_web_app/fire_chat/rooms_bloc/rooms_cubit.dart';
import 'package:chat_web_app/util/app_color_manager.dart';
import 'package:chat_web_app/util/extensions.dart';
import 'package:chat_web_app/util/my_text_form_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../chat_service/core/firebase_chat_core.dart';
import '../util/my_button.dart';
import '../util/my_style.dart';
import 'open_room_cubit/open_room_cubit.dart';

class ListRooms extends StatefulWidget {
  const ListRooms({Key? key}) : super(key: key);

  @override
  State<ListRooms> createState() => _ListRoomsState();
}

class _ListRoomsState extends State<ListRooms> {
  Room? selectedRoom;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsCubit, RoomsInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }

        return ListView.separated(
          itemCount: state.result.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final room = state.result[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 7.0).r,
              color: selectedRoom?.id == room.id
                  ? AppColorManager.mainColor.withOpacity(0.3)
                  : room.isRead
                      ? Colors.white
                      : Colors.grey[100],
              child: ListTile(
                onTap: () async {
                  await context.read<MessagesCubit>().state.stream?.cancel();
                  setState(() {
                    selectedRoom = room;
                    context.read<OpenRoomCubit>().openRoomByRoom(room);
                  });
                },
                leading: SizedBox(
                  height: 120.r,
                  width: 120.r,
                  child: ImageMultiType(
                    url: room.otherUser.imageUrl !,
                    height: 130.0.r,
                  ),
                ),
                title: (!state.mRequest)
                    ? DrawableText(
                        selectable: false,
                        text: room.otherUser.name,
                        size: 12.0.sp,
                        matchParent: true,
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DrawableText(
                            selectable: false,
                            text: room.firstUser.name,
                            size: 12.0.sp,
                            matchParent: true,
                          ),
                          // if(room.me==null)
                          DrawableText(
                            selectable: false,
                            text: room.secondUser.name,
                            size: 12.0.sp,
                            matchParent: true,
                          ),
                        ],
                      ),
                subtitle: room.lastMessages?.firstOrNull?.latestMessage(room),
                trailing: room.updatedAt == null
                    ? null
                    : DrawableText(
                        selectable: false,
                        textAlign: TextAlign.center,
                        size: 10.0.sp,
                        color: Colors.grey,
                        text: DateTime.fromMillisecondsSinceEpoch(
                          room.updatedAt!,
                        ).formatDateTimeVertical,
                      ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[100],
            indent: 0.03.sw,
            endIndent: 0.03.sw,
          ),
        );
      },
    );
  }
}
