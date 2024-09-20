import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:m_cubit/abstraction.dart';

import '../../../core/strings/enum_manager.dart';
import '../../../core/util/abstraction.dart';

part 'users_state.dart';

class UsersCubit extends MCubit<UsersInitial> {
  UsersCubit() : super(UsersInitial.initial());

  @override
  String get nameCache => 'users';

  Future<void> getChatUsers() async {
    await setData();

    _users();
  }

  /// Returns a stream of messages from Firebase for a given room.
  void _users() {
    late final Query<Map<String, dynamic>> query;

    query = FirebaseFirestore.instance
        .collection('users')
        .orderBy('updatedAt', descending: true)
        .where(
          'updatedAt',
          isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
              state.result.lastOrNull?.updatedAt ?? 0),
        );

    final stream = query.snapshots().listen((snapshot) async {
      final users = snapshot.docs.map(
        (doc) {
          final data = doc.data();

          data['id'] = doc.id;
          data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
          data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
          data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

          return types.User.fromJson(data);
        },
      );

      await saveData(users);

      if (isClosed) return;

      await setData();
    });

    emit(state.copyWith(stream: stream));
  }

  Future<void> setData() async {
    final dataList = (await getListCached(fromJson: types.User.fromJson));

    emit(state.copyWith(result: dataList));
  }

  types.User? findUser(String id)  {
    final user = state.result.firstWhereOrNull((e) => e.id == id);
    return user;
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    return () {};
  }
}
