import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../../core/strings/enum_manager.dart';
import '../../../main.dart';
import '../util.dart';

part 'get_rooms_state.dart';

class RoomsCubit extends Cubit<RoomsInitial> {
  RoomsCubit() : super(RoomsInitial.initial());

  Future<void> getChatRooms() async {
    if (await firebaseUserAsync == null) return;

    emit(state.copyWith(statuses: CubitStatuses.loading));

    rooms();
  }

  /// Returns a stream of messages from Firebase for a given room.
  void rooms() {
    var query = FirebaseFirestore.instance
        .collection('rooms')
        .orderBy('updatedAt', descending: true)
        .where(
      'userIds',
      arrayContains: firebaseUser?.uid,
    )
        .where(
      'updatedAt',
      isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
        getLatestUpdatedFromHive,
      ),
    );

    final stream = query.snapshots().listen((snapshot) async {
      final listRooms = await processRoomsQuery(
        firebaseUser!,
        FirebaseFirestore.instance,
        snapshot,
        'users',
      );

      await storeRoomsInHive(listRooms);

      if (!isClosed) {
        _setData();
      }
    });

    emit(state.copyWith(stream: stream));
  }

  int get getLatestUpdatedFromHive {
    return state.allRooms.firstOrNull?.updatedAt ?? 0;
  }

  void _setData() {
    if (isClosed) return;

    final allRooms = getRoomsFromHive
      ?..sort(
        (a, b) => (b.updatedAt ?? 0).compareTo(a.updatedAt ?? 0),
      );

    emit(
      state.copyWith(
        allRooms: allRooms,
        statuses: CubitStatuses.done,
      ),
    );
  }

  List<types.Room>? get getRoomsFromHive {
    return roomsBox.values.map((e) {
      return types.Room.fromJson(jsonDecode(e));
    }).toList();
  }

  Future<void> storeRoomsInHive(List<types.Room> rooms) async {
    for (var e in rooms) {
      await roomsBox.put(e.id, jsonEncode(e));
    }
  }

  void updateRooms() {
    _setData();
  }

  Future<types.Room?> getRoomByUser(String? id) async {
    if (id == null) return null;
    for (var e in state.allRooms) {
      for (var e1 in e.users) {
        if (e1.firstName == id) {
          return e;
        }
      }
    }

    for (var e in await getChatUsers()) {
      if (e.firstName == id) {
        var newRoom = await FirebaseChatCore.instance.createRoom(e);

        return newRoom;
      }
    }
    return null;
  }

  void reInitial() {
    emit(RoomsInitial.initial());
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    return () {};
  }
}
