import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/services/chat_service/core/firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../core/api_manager/api_service.dart';
import '../../../core/strings/enum_manager.dart';
import '../../../core/util/abstraction.dart';
import '../../../services/chat_service/core/util.dart';

part 'rooms_state.dart';

class RoomsCubit extends MCubit<RoomsInitial> {
  RoomsCubit() : super(RoomsInitial.initial());

  @override
  String get nameCache => 'rooms1';

  @override
  String get filter => AppProvider.myId.toString();

  Future<void> getChatRooms(bool isAdmen) async {
    if(AppProvider.myId ==null)return;
    emit(state.copyWith(request: isAdmen));

    await setData();

    rooms();
  }

  /// Returns a stream of messages from Firebase for a given room.
  void rooms() {
    late final Query<Map<String, dynamic>> query;

    query = FirebaseFirestore.instance
        .collection('rooms')
        .orderBy('updatedAt', descending: true)
        .where('userIds', arrayContains: AppProvider.myId.toString())
        .where(
          'updatedAt',
          isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
            state.result.lastOrNull?.updatedAt ?? 0,
          ),
        );
    //
    // loggerObject.i('requested get room ');
    // loggerObject.i(DateTime.fromMillisecondsSinceEpoch(
    //     state.result.firstOrNull?.updatedAt ?? 0));
    // loggerObject.i(DateTime.fromMillisecondsSinceEpoch(
    //     state.result.lastOrNull?.updatedAt ?? 0));

    final stream = query.snapshots().listen((snapshot) async {
      final listRooms = await processRoomsQuery(
        FirebaseFirestore.instance,
        snapshot,
        'users',
      );

      await sortDataWithIds(listRooms);

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

     roomsCached.removeWhere((e) => e.otherUser.id=='-1');

    final roomIndex = roomsCached.indexWhere((element) {
      return element.users.firstWhereOrNull((e) => e.id == '0') != null;
    });

    if (roomIndex > -1) {
      final room = roomsCached.removeAt(roomIndex);
      roomsCached.insert(0,room);
    }

    emit(state.copyWith(result: roomsCached));
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    return () {};
  }
}
