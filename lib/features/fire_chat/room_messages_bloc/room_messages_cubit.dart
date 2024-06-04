import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/features/welcome_message/bloc/welcome_messages_cubit/welcome_messages_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../../../core/app/app_widget.dart';
import '../../../core/strings/enum_manager.dart';
import '../../../main.dart';
import '../../welcome_message/data/response/welcome_message_response.dart';
import '../util.dart';

part 'room_messages_state.dart';

class MessagesCubit extends Cubit<MessagesInitial> {
  MessagesCubit() : super(MessagesInitial.initial());

  Future<void> getChatRoomMessage(types.Room room) async {
    if (firebaseUser == null) return;
    emit(state.copyWith(room: room));
    messages(room);
  }

  /// Returns a stream of messages from Firebase for a given room.
  Future<void> messages(types.Room room) async {
    var query = FirebaseFirestore.instance
        .collection('rooms/${room.id}/messages')
        .orderBy('createdAt', descending: true)
        .where(
          'createdAt',
          isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
            getLatestUpdatedFromHive,
          ),
        );

    loggerObject.w(getChatMember(room.users).firstName);
    if (getChatMember(room.users).firstName == '0') {
      final list = ctx?.read<WelcomeMessagesCubit>().state.result ?? [];

      var user = getChatMember(room.users);

      final deletedKeys = messageBox.keys.where(
        (e) => (e as String).startsWith('_welcome'),
      );
      await messageBox.deleteAll(deletedKeys);
      for (var e in list) {
        var message = types.TextMessage(
          author: user,
          id: e.id.toString(),
          text: e.message,
          createdAt: e.id,
        );
        await messageBox.put('_welcome${e.id}_', jsonEncode(message));

        if (e.image.isNotEmpty) {
          var message = types.ImageMessage(
            author: user,
            createdAt: e.id,
            id: '_welcome${e.id}image_',
            name: 'image',
            size: 100,
            uri: e.image,
          );
          await messageBox.put(e.id.toString(), jsonEncode(message));
        }
      }
    }

    final stream = query.snapshots().listen((snapshot) async {
      final newMessages = <types.Message>[];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final author = room.users.firstWhere(
          (u) => u.id == data['authorId'],
          orElse: () => types.User(id: data['authorId'] as String),
        );

        data['author'] = author.toJson();
        data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
        data['id'] = doc.id;
        data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

        await messageBox.put(doc.id, jsonEncode(data));
        final message = types.Message.fromJson(data);
        await latestMessagesBox.put(room.id, jsonEncode(data));
        newMessages.add(message);
      }

      if (!isClosed) {
        emit(
          state.copyWith(
            allMessages: messageBox.values
                .map((e) => types.Message.fromJson(jsonDecode(e)))
                .toList()
              ..sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0)),
          ),
        );
      }
    });

    await latestUpdateMessagesBox.put(room.id, room.updatedAt ?? 0);

    emit(state.copyWith(stream: stream, roomId: room.id));
  }

  int get getLatestUpdatedFromHive {
    return state.allMessages.firstOrNull?.updatedAt ?? 0;
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    // if (state.oldLength < state.allMessages.length) {
    //   ctx?.read<RoomsCubit>().getChatRooms();
    // }
    return () {};
  }
}
