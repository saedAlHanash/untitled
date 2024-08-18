import 'dart:async';

import 'package:chat_web_app/api_manager/api_service.dart';
import 'package:chat_web_app/fire_chat/chat.dart';
import 'package:chat_web_app/fire_chat/list_rooms.dart';
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

import '../chat_service/core/firebase_chat_core.dart';
import '../util/my_button.dart';
import '../util/my_style.dart';
import 'open_room_cubit/open_room_cubit.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  ///Timer to delay request search
  Timer? _debounce;

  ///search in DB and render list widget
  void searchFun(String val) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), ()  {
      context.read<RoomsCubit>().search(q: val);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OpenRoomCubit, OpenRoomInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        if (state.result != null) {
          context.read<MessagesCubit>().getChatRoomMessage(state.result!);
        }
      },
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(10).r,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13.0.r),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 16.0),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
                      child: MyTextFormOutLineWidget(
                        onChanged: searchFun,
                        hint: 'Search',
                      ),
                    ),
                    const Expanded(child: ListRooms()),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: BlocBuilder<OpenRoomCubit, OpenRoomInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  if (state.result == null) return 0.0.verticalSpace;
                  return ChatPage(room: state.result!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
