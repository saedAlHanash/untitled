import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:m_cubit/abstraction.dart';

import '../../../core/api_manager/api_service.dart';
import '../../../core/app/app_provider.dart';
import '../../../core/util/cheker_helper.dart';

part 'messages_state.dart';

class MessagesCubit extends MCubit<MessagesInitial> {
  MessagesCubit() : super(MessagesInitial.initial());

  @override
  String get nameCache => state.mRequest.id.toString();

  @override
  String get filter => state.filter;

  Future<void> getChatRoomMessage(types.Room room) async {
    if (AppProvider.myId.isEmpty) return;

    emit(state.copyWith(request: room));

    await setData();

    await Future.delayed(const Duration(seconds: 2));

    messages(room);
  }

  /// Returns a stream of messages from Firebase for a given room.
  Future<void> messages(types.Room room) async {
    var query = FirebaseFirestore.instance
        .collection('rooms/${room.id}/messages')
        .orderBy('createdAt', descending: true)
        .limit(100)
        .where(
          'updatedAt',
          isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
              state.result.firstOrNull?.updatedAt ?? 0),
        );

    loggerObject.i('requested get messages ');

    await state.stream?.cancel();
    final stream = query.snapshots().listen((snapshot) async {
      final messages = snapshot.docs.map(
        (doc) {
          final data = doc.data();
          final author = room.users.firstWhere(
            (u) => u.id == data['authorId'],
            orElse: () => types.User(id: data['authorId'] as String),
          );

          data['author'] = author.toJson();
          data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
          data['id'] = doc.id;
          data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;
          return data;
        },
      );

      if (messages.isEmpty) return;

      await saveData(
        messages,
        clearId: false,
        sortKey: messages.map((e) => ((e['createdAt'] as int?) ?? 0)).toList(),
      );

      if (isClosed) return;

      await setData();
    });

    emit(state.copyWith(stream: stream));
  }

  Future<void> setData() async {
    final nowTimeMillis = DateTime.now().millisecondsSinceEpoch;

    final allMessages = await getListCached(
      fromJson: types.Message.fromJson,
      deleteFunction: (json) {
        final type = json['type'];
        return (type == 'file' || type == 'video') &&
            isMoreThanOneMonth(json['createdAt'] ?? 0, nowTimeMillis);
      },
    )
      ..sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));

    emit(state.copyWith(result: allMessages));
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    return () {};
  }
}
