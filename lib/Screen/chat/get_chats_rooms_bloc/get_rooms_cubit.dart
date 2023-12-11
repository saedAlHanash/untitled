import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../../main.dart';
import '../../Trainee Screens/coupon/coupon_cubit/coupon_cubit.dart';
import '../../chat/util.dart';

part 'get_rooms_state.dart';

class GetRoomsCubit extends Cubit<GetRoomsInitial> {
  GetRoomsCubit() : super(GetRoomsInitial.initial());

  Future<void> getChatRooms() async {
    loggerObject.w(FirebaseChatCore.instance.firebaseUser);
    if (firebaseUser == null) return;

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

      storeRoomsInHive(listRooms);

      if (!isClosed) {
        _setData();
      }
    });

    emit(state.copyWith(stream: stream));
  }

  Future<int> get getLatestUpdatedRoom async {
    final latestUpdateItem = await FirebaseFirestore.instance
        .collection('rooms')
        .orderBy('updatedAt', descending: true)
        .where(
          'userIds',
          arrayContains: firebaseUser?.uid,
        )
        .limit(1)
        .get();

    final item = latestUpdateItem.docs.firstOrNull?.data();

    item?['updatedAt'] = item['updatedAt']?.millisecondsSinceEpoch;

    return item?['updatedAt'] ?? 1;
  }

  int get getLatestUpdatedFromHive {
    return state.allRooms.firstOrNull?.updatedAt ?? 0;
  }

  void _setData() {
    final rooms = getRoomsFromHive;

    // rooms.removeWhere((e) => (e.name??'').toLowerCase().contains('customer service'));
    final allRooms = rooms
      // ..addAll(rooms)
      ..sort((a, b) => (b.updatedAt ?? 0).compareTo(a.updatedAt ?? 0));

    emit(
      state.copyWith(
          allRooms: allRooms,
          statuses: CubitStatuses.done,
          noReadMessages: allRooms.firstWhereOrNull((e) => e.isNotReed) != null),
    );
  }

  Future<types.Room?> getRoomByUser(String? id) async {
    if (id == null) return null;

    for (var e in state.myRooms) {
      for (var e1 in e.users) {
        if (e1.id == id) {
          return e;
        }
      }
    }

    for (var e in await getChatUsers()) {
      if (e.id == id) {
        var newRoom = await FirebaseChatCore.instance.createRoom(e);
        // localListRooms.add(newRoom);
        return newRoom;
      }
    }
    return null;
  }

  List<types.Room> get getRoomsFromHive {
    return roomsBox.values.map((e) {
      return types.Room.fromJson(jsonDecode(e));
    }).toList();
  }

  Future<void> storeRoomsInHive(List<types.Room> rooms) async {
    for (var i = 0; i < rooms.length; i++) {
      final e = rooms[i];
      await roomsBox.put(e.id, jsonEncode(e));
    }
  }

  void updateRooms() {
    _setData();
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    return () {};
  }
}
