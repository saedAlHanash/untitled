import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_storm/features/fire_chat/userss_bloc/users_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../core/api_manager/api_service.dart';
import '../../../core/app/app_provider.dart';
import '../../../core/app/app_widget.dart';

/// Extension with one [toShortString] method.
extension RoleToShortString on types.Role {
  /// Converts enum to the string equal to enum's name.
  String toShortString() => toString().split('.').last;
}

/// Extension with one [toShortString] method.
extension RoomTypeToShortString on types.RoomType {
  /// Converts enum to the string equal to enum's name.
  String toShortString() => toString().split('.').last;
}

/// Fetches user from Firebase and returns a promise.
Future<Map<String, dynamic>> fetchUser(
  FirebaseFirestore instance,
  String userId,
  String usersCollectionName, {
  String? role,
}) async {

  final userFromCache = ctx?.read<UsersCubit>().findUser(userId);

  if (userFromCache != null) {
    return userFromCache.toJson();
  }

  final doc = await instance.collection(usersCollectionName).doc(userId).get();
  if (doc.data() == null) return {'id': '-1'};
  final data = doc.data()!;

  data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
  data['id'] = doc.id;
  data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
  data['role'] = role;
  data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

  return data;
}

/// Returns a list of [types.Room] created from Firebase query.
/// If room has 2 participants, sets correct room name and image.
Future<List<types.Room>> processRoomsQuery(
  FirebaseFirestore instance,
  QuerySnapshot<Map<String, dynamic>> query,
  String usersCollectionName,
) async {
  final futures = query.docs.map(
    (doc) => processRoomDocument(
      doc,
      instance,
      usersCollectionName,
    ),
  );

  return await Future.wait(futures);
}

/// Returns a [types.Room] created from Firebase document.
Future<types.Room> processRoomDocument(
  DocumentSnapshot<Map<String, dynamic>> doc,
  FirebaseFirestore instance,
  String usersCollectionName,
) async {
  final data = doc.data()!;

  data['id'] = doc.id;
  data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
  data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

  var imageUrl = data['imageUrl'] as String?;
  var name = data['name'] as String?;
  final type = data['type'] as String;
  final userIds = data['userIds'] as List<dynamic>;
  final userRoles = data['userRoles'] as Map<String, dynamic>?;

  final users = await Future.wait(
    userIds.map(
      (userId) => fetchUser(
        instance,
        userId as String,
        usersCollectionName,
        role: userRoles?[userId] as String?,
      ),
    ),
  );

  if (type == types.RoomType.direct.toShortString()) {
    try {
      final otherUser = users.firstWhere(
        (u) => u['id'] != AppProvider.myId,
      );

      imageUrl = otherUser['imageUrl'] as String?;
      name = '${otherUser['firstName'] ?? ''} ${otherUser['lastName'] ?? ''}'.trim();
    } catch (e) {
      loggerObject.e(e);
    }
  }

  data['imageUrl'] = imageUrl;
  data['name'] = name;
  data['users'] = users;

  if (data['latestMessage'] != null) {
    final metaData = <String, dynamic>{};

    if (data['latestMessage'] != null && data['latestMessage'] is Map) {
      final message = data['latestMessage'] as Map<String, dynamic>;

      message['author'] = types.User(id: message['authorId'] as String).toJson();
      message['createdAt'] = message['createdAt']?.millisecondsSinceEpoch;
      message['id'] = doc.id;
      message['updatedAt'] = message['updatedAt']?.millisecondsSinceEpoch;

      data['lastMessages'] = [message];
    }

    metaData['latestSeen'] =
        data['latestSeen${AppProvider.myId}']?.millisecondsSinceEpoch;

    data['metadata'] = metaData;
  }

  return types.Room.fromJson(data);
}
