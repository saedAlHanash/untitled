import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chat_web_app/api_manager/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../main.dart';
import '../../api_manager/enum_manager.dart';
import '../../services/caching_service/abstraction.dart';

part 'messages_state.dart';

class MessagesCubit extends MCubit<MessagesInitial> {
  MessagesCubit() : super(MessagesInitial.initial());

  @override
  String get nameCache => state.mRequest.id.toString();

  @override
  String get filter => '';

  Future<void> getChatRoomMessage(types.Room room) async {
    emit(state.copyWith(request: room));

    final data =
        (await getListCached()).map((e) => types.Message.fromJson(e)).toList();

    final allMessages = data
      ..sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));

    emit(state.copyWith(result: allMessages));

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
          'createdAt',
          isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
              state.result.firstOrNull?.updatedAt ?? 0),
        );



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

      await storeData(messages);

      if (!isClosed) {
        final data = (await getListCached())
            .map((e) => types.Message.fromJson(e))
            .toList();

        final allMessages = data
          ..sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));

        emit(state.copyWith(result: allMessages));
      }
    });

    emit(state.copyWith(stream: stream));
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    return () {};
  }
}
