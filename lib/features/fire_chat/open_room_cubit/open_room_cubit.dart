import 'package:fitness_storm/services/chat_service/chat_service_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../core/app/app_provider.dart';
import '../../../router/app_router.dart';
import '../../../services/chat_service/core/firebase_chat_core.dart';
import '../../trainer/data/response/trainer.dart';

part 'open_room_state.dart';

class OpenRoomCubit extends Cubit<OpenRoomInitial> {
  OpenRoomCubit() : super(OpenRoomInitial.initial());

  Future<void> openRoom(User chatUser) async {
    if (AppProvider.myId.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, request: chatUser));

    final room = await FirebaseChatCore.instance.createRoom(chatUser);
    emit(state.copyWith(statuses: CubitStatuses.done, request: room));
    // Get.context?.read<MessagesCubit>().state.stream?.cancel();
    startChatPage(room);
  }

  Future<void> openRoomByRoom(Room room) async {
    if (AppProvider.myId.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.init));
    Future(() =>
        emit(state.copyWith(statuses: CubitStatuses.done, request: room)));
    // Get.context?.read<MessagesCubit>().state.stream?.cancel();
    startChatPage(room);
  }

  Future<void> openRoomByUserId(String userId, {TrainerModel? trainer}) async {
    if (AppProvider.myId.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final chatUser = await ChatServiceCore.getUser(userId, trainer: trainer);

    if (chatUser == null) {
      emit(state.copyWith(statuses: CubitStatuses.error));
      return;
    }

    final room = await FirebaseChatCore.instance.createRoom(chatUser);
    emit(state.copyWith(statuses: CubitStatuses.done, request: room));
    // Get.context?.read<MessagesCubit>().state.stream?.cancel();
    startChatPage(room);
  }

  Future<void> openRoomCustomerService() async {
    if (AppProvider.myId.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final chatUser = await ChatServiceCore.getUser('0');

    if (chatUser == null) {
      emit(state.copyWith(statuses: CubitStatuses.error));
      return;
    }

    final room = await FirebaseChatCore.instance.createRoom(chatUser);
    emit(state.copyWith(statuses: CubitStatuses.done, request: room));
    // Get.context?.read<MessagesCubit>().state.stream?.cancel();
    startChatPage(room);
  }
}
