import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../main.dart';
import '../../Trainee Screens/coupon/coupon_cubit/coupon_cubit.dart';
import '../../chat/util.dart';

part 'room_messages_state.dart';

class RoomMessagesCubit extends Cubit<RoomMessagesInitial> {
  RoomMessagesCubit() : super(RoomMessagesInitial.initial());

  Future<void> getChatRoomMessage(types.Room room) async {
    if (firebaseUser == null) return;
    messages(room);
  }

  /// Returns a stream of messages from Firebase for a given room.
  void messages(types.Room room) {
    var query = FirebaseFirestore.instance
        .collection('rooms/${room.id}/messages')
        .orderBy('createdAt', descending: true)
        .where(
          'createdAt',
          isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
            getLatestUpdatedFromHive,
          ),
        );

    final stream = query.snapshots().listen((snapshot) {
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

        roomMessage.put(doc.id, jsonEncode(data));

        newMessages.add(types.Message.fromJson(data));
      }

      if (!isClosed) {
        emit(
          state.copyWith(
            allMessages: roomMessage.values
                .map((e) => types.Message.fromJson(jsonDecode(e)))
                .toList()
              ..sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0)),
          ),
        );
      }
    });

    latestUpdateMessagesBox.put(room.id, room.updatedAt ?? 0);

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
    //   ctx?.read<GetRoomsCubit>().getChatRooms();
    // }
    return () {};
  }
}
