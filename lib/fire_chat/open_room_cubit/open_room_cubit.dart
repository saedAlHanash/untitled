import 'package:bloc/bloc.dart';
import 'package:chat_web_app/api_manager/api_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../../api_manager/enum_manager.dart';
import '../../chat_service/chat_service_core.dart';
import '../../chat_service/core/firebase_chat_core.dart';
import '../../util/abstraction.dart';

part 'open_room_state.dart';

class OpenRoomCubit extends Cubit<OpenRoomInitial> {
  OpenRoomCubit() : super(OpenRoomInitial.initial());

  Future<void> openRoom(User chatUser) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: chatUser));

    final room = await FirebaseChatCore.instance.createRoom(chatUser);
    emit(state.copyWith(statuses: CubitStatuses.done, result: room));
    // startChatPage(room);
  }

  Future<void> openRoomByRoom(Room room) async {
    if (state.result != null) {
      ChatServiceCore.latestSeenRoom(state.result!.id);
    }
    emit(state.copyWith(statuses: CubitStatuses.loading));
    Future.delayed(Duration(seconds: 1),
        () => emit(state.copyWith(statuses: CubitStatuses.done, result: room)));
    // startChatPage(room);
  }

  Future<void> openRoomByUserId(String userId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final chatUser = await ChatServiceCore.getUser(userId);

    if (chatUser == null) {
      emit(state.copyWith(statuses: CubitStatuses.error));
      return;
    }

    final room = await FirebaseChatCore.instance.createRoom(chatUser);
    emit(state.copyWith(statuses: CubitStatuses.done, result: room));
    // startChatPage(room);
  }

  Future<void> openRoomCustomerService() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final chatUser = await ChatServiceCore.getUser('0');

    if (chatUser == null) {
      emit(state.copyWith(statuses: CubitStatuses.error));
      return;
    }

    final room = await FirebaseChatCore.instance.createRoom(chatUser);
    emit(state.copyWith(statuses: CubitStatuses.done, result: room));
    // startChatPage(room);
  }
}
