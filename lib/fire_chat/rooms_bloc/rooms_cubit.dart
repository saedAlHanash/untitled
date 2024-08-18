import 'dart:async';

import 'package:chat_web_app/api_manager/api_service.dart';
import 'package:chat_web_app/services/caching_service/abstraction.dart';
import 'package:chat_web_app/util/extensions.dart';
import 'package:chat_web_app/util/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../api_manager/enum_manager.dart';
import '../../chat_service/core/util.dart';

part 'rooms_state.dart';

class RoomsCubit extends MCubit<RoomsInitial> {
  RoomsCubit() : super(RoomsInitial.initial());

  @override
  String get nameCache => 'rooms';

  @override
  String get filter => state.mRequest.toString();

  Future<void> getChatRooms(bool isAdmen) async {
    emit(state.copyWith(request: isAdmen));

    await setData();

    rooms();
  }

  /// Returns a stream of messages from Firebase for a given room.
  void rooms() {
    late final Query<Map<String, dynamic>> query;

    if (!isAdmin) {
      query = FirebaseFirestore.instance
          .collection('rooms')
          .orderBy('updatedAt', descending: true)
          .where('userIds', arrayContains: '0')
          .where(
            'updatedAt',
            isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
              state.result.lastOrNull?.updatedAt ?? 0,
            ),
          );
    } else {
      query = FirebaseFirestore.instance
          .collection('rooms')
          .orderBy('updatedAt', descending: true)
          .where(
            'updatedAt',
            isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
              state.result.lastOrNull?.updatedAt ?? 0,
            ),
          );
    }


    final stream = query.snapshots().listen((snapshot) async {
      final listRooms = await processRoomsQuery(
        FirebaseFirestore.instance,
        snapshot,
        'users',
      );

      loggerObject.t(snapshot.docs.length);

      await storeData(listRooms);

      if (isClosed) return;
      await setData();
    });

    emit(state.copyWith(stream: stream));
  }

  Future<void> setData() async {
    final data =
        (await getListCached()).map((e) => types.Room.fromJson(e)).toList();

    final roomsCached = data
      ..sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));

    roomsCached.removeWhere((e) => e.otherUser.id == '-1');

    if (state.search.isNotEmpty) {
      emit(
        state.copyWith(
            result: roomsCached
                .where((room) => room.usersName
                    .toLowerCase()
                    .contains(state.search.toLowerCase()))
                .toList()),
      );
    } else {
      emit(state.copyWith(result: roomsCached));
    }
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    return () {};
  }

  void search({required String q}) {
    emit(state.copyWith(search: q));
    setData();
  }
}
