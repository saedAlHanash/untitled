import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../core/app/app_provider.dart';
import '../../../core/strings/app_color_manager.dart';
import 'firebase_chat_core_config.dart';
import 'util.dart';

class FirebaseChatCore {
  FirebaseChatCore._privateConstructor();

  FirebaseChatCoreConfig config = const FirebaseChatCoreConfig(
    null,
    'rooms',
    'users',
  );

  /// Singleton instance.
  static final FirebaseChatCore instance =
      FirebaseChatCore._privateConstructor();

  /// Gets proper [FirebaseFirestore] instance.
  FirebaseFirestore getFirebaseFirestore() => config.firebaseAppName != null
      ? FirebaseFirestore.instanceFor(
          app: Firebase.app(config.firebaseAppName!),
        )
      : FirebaseFirestore.instance;

  /// Sets custom config to change default names for rooms
  /// and users collections. Also see [FirebaseChatCoreConfig].
  void setConfig(FirebaseChatCoreConfig firebaseChatCoreConfig) {
    config = firebaseChatCoreConfig;
  }

  /// Creates a direct chat for 2 people. Add [metadata] for any additional
  /// custom data.
  Future<types.Room> createRoom(
    types.User otherUser, {
    Map<String, dynamic>? metadata,
  }) async {
    if (AppProvider.myId.isEmpty) throw Exception('myId  is null');
    // Sort two user ids array to always have the same array for both users,
    // this will make it easy to find the room if exist and make one read only.

    final userIds = [AppProvider.myId, otherUser.id]..sort();

    final roomQuery = await getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .where('type', isEqualTo: types.RoomType.direct.toShortString())
        .where('userIds', isEqualTo: userIds)
        .limit(1)
        .get();

    // Check if room already exist.
    if (roomQuery.docs.isNotEmpty) {
      final room = (await processRoomsQuery(
        getFirebaseFirestore(),
        roomQuery,
        config.usersCollectionName,
      ))
          .first;

      return room;
    }

    // To support old chats created without sorted array,
    // try to check the room by reversing user ids array.
    final oldRoomQuery = await getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .where('type', isEqualTo: types.RoomType.direct.toShortString())
        .where('userIds', isEqualTo: userIds.reversed.toList())
        .limit(1)
        .get();

    // Check if room already exist.
    if (oldRoomQuery.docs.isNotEmpty) {
      final room = (await processRoomsQuery(
        getFirebaseFirestore(),
        oldRoomQuery,
        config.usersCollectionName,
      ))
          .first;

      return room;
    }
    Map<String, dynamic>? currentUser;
    try {
      currentUser = await fetchUser(
        getFirebaseFirestore(),
        AppProvider.myId,
        config.usersCollectionName,
      );
    } catch (e) {}

    final users = [
      if (currentUser != null) types.User.fromJson(currentUser),
      otherUser
    ];

    // Create new room with sorted user ids array.
    final room = await getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .add({
      'createdAt': FieldValue.serverTimestamp(),
      'imageUrl': null,
      'metadata': metadata,
      'name': null,
      'type': types.RoomType.direct.toShortString(),
      'updatedAt': FieldValue.serverTimestamp(),
      'userIds': userIds,
      'userRoles': null,
    });

    return types.Room(
      id: room.id,
      metadata: metadata,
      type: types.RoomType.direct,
      users: users,
    );
  }

  /// Creates [types.User] in Firebase to store name and avatar used on
  /// rooms list.
  Future<void> createUserInFirestore(types.User user) async {
    await getFirebaseFirestore()
        .collection(config.usersCollectionName)
        .doc(user.id)
        .set({
      'createdAt': FieldValue.serverTimestamp(),
      'firstName': user.firstName,
      'imageUrl': user.imageUrl,
      'lastName': user.lastName,
      'lastSeen': FieldValue.serverTimestamp(),
      'metadata': user.metadata,
      'role': user.role?.toShortString(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Removes message document.
  Future<void> deleteMessage(String roomId, String messageId) async {
    await getFirebaseFirestore()
        .collection('${config.roomsCollectionName}/$roomId/messages')
        .doc(messageId)
        .delete();
  }

  /// Removes room document.
  Future<void> deleteRoom(String roomId) async {
    await getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .doc(roomId)
        .delete();
  }

  /// Removes [types.User] from `users` collection in Firebase.
  Future<void> deleteUserFromFirestore(String userId) async {
    await getFirebaseFirestore()
        .collection(config.usersCollectionName)
        .doc(userId)
        .delete();
  }

  /// Returns a stream of messages from Firebase for a given room.
  Stream<List<types.Message>> messages(
    types.Room room, {
    List<Object?>? endAt,
    List<Object?>? endBefore,
    int? limit,
    List<Object?>? startAfter,
    List<Object?>? startAt,
  }) {
    var query = getFirebaseFirestore()
        .collection('${config.roomsCollectionName}/${room.id}/messages')
        .orderBy('createdAt', descending: true);

    if (endAt != null) {
      query = query.endAt(endAt);
    }

    if (endBefore != null) {
      query = query.endBefore(endBefore);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    if (startAfter != null) {
      query = query.startAfter(startAfter);
    }

    if (startAt != null) {
      query = query.startAt(startAt);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs.fold<List<types.Message>>(
            [],
            (previousValue, doc) {
              final data = doc.data();

              final author = room.users.firstWhere(
                (u) => u.id == data['authorId'],
                orElse: () => types.User(id: data['authorId'] as String),
              );

              data['author'] = author.toJson();
              data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
              data['id'] = doc.id;
              data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

              return [...previousValue, types.Message.fromJson(data)];
            },
          ),
        );
  }

  /// Returns a stream of changes in a room from Firebase.
  Stream<types.Room> room(String roomId) {
    return getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .doc(roomId)
        .snapshots()
        .asyncMap(
          (doc) => processRoomDocument(
            doc,
            getFirebaseFirestore(),
            config.usersCollectionName,
          ),
        );
  }

  // /// Returns a stream of rooms from Firebase. Only rooms where current
  // /// logged in user exist are returned. [orderByUpdatedAt] is used in case
  // /// you want to have last modified rooms on top, there are a couple
  // /// of things you will need to do though:
  // /// 1) Make sure `updatedAt` exists on all rooms
  // /// 2) Write a Cloud Function which will update `updatedAt` of the room
  // /// when the room changes or new messages come in
  // /// 3) Create an Index (Firestore Database -> Indexes tab) where collection ID
  // /// is `rooms`, field indexed are `userIds` (type Arrays) and `updatedAt`
  // /// (type Descending), query scope is `Collection`.
  // Stream<List<types.Room>> rooms({bool orderByUpdatedAt = false}) {
  //   final collection = orderByUpdatedAt
  //       ? getFirebaseFirestore()
  //           .collection(config.roomsCollectionName)
  //           .where('userIds', arrayContains: AppProvider.myId)
  //           .orderBy('updatedAt', descending: true)
  //       : getFirebaseFirestore()
  //           .collection(config.roomsCollectionName)
  //           .where('userIds', arrayContains: AppProvider.myId);
  //
  //   return collection.snapshots().asyncMap(
  //         (query) => processRoomsQuery(
  //           getFirebaseFirestore(),
  //           query,
  //           config.usersCollectionName,
  //         ),
  //       );
  // }

  /// Sends a message to the Firestore. Accepts any partial message and a
  /// room ID. If arbitraty data is provided in the [partialMessage]
  /// does nothing.
  void sendMessage(dynamic partialMessage, String roomId) async {
    types.Message? message;

    if (partialMessage is types.PartialCustom) {
      message = types.CustomMessage.fromPartial(
        author: types.User(id: AppProvider.myId),
        id: '',
        partialCustom: partialMessage,
      );
    } else if (partialMessage is types.PartialFile) {
      message = types.FileMessage.fromPartial(
        author: types.User(id: AppProvider.myId),
        id: '',
        partialFile: partialMessage,
      );
    } else if (partialMessage is types.PartialImage) {
      message = types.ImageMessage.fromPartial(
        author: types.User(id: AppProvider.myId),
        id: '',
        partialImage: partialMessage,
      );
    } else if (partialMessage is types.PartialText) {
      message = types.TextMessage.fromPartial(
        author: types.User(id: AppProvider.myId),
        id: '',
        partialText: partialMessage,
      );
    }

    if (message != null) {
      final messageMap = message.toJson();

      messageMap.removeWhere((key, value) => key == 'author' || key == 'id');
      messageMap['authorId'] = AppProvider.myId;
      messageMap['createdAt'] = FieldValue.serverTimestamp();
      messageMap['updatedAt'] = FieldValue.serverTimestamp();

      await getFirebaseFirestore()
          .collection('${config.roomsCollectionName}/$roomId/messages')
          .add(messageMap);

      await getFirebaseFirestore()
          .collection(config.roomsCollectionName)
          .doc(roomId)
          .update(
        {
          'updatedAt': FieldValue.serverTimestamp(),
          'latestMessage': messageMap,
        },
      );
    }
  }

  Future<void> latestSeenRoom(String roomId) async {
    await getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .doc(roomId)
        .update(
      {
        'latestSeen${AppProvider.myId}': FieldValue.serverTimestamp(),
      },
    );
  }

  /// Updates a message in the Firestore. Accepts any message and a
  /// room ID. Message will probably be taken from the [messages] stream.
  void updateMessage(types.Message message, String roomId) async {
    if (message.author.id != AppProvider.myId) return;

    final messageMap = message.toJson();
    messageMap.removeWhere(
      (key, value) => key == 'author' || key == 'createdAt' || key == 'id',
    );
    messageMap['authorId'] = message.author.id;
    messageMap['updatedAt'] = FieldValue.serverTimestamp();

    await getFirebaseFirestore()
        .collection('${config.roomsCollectionName}/$roomId/messages')
        .doc(message.id)
        .update(messageMap);
  }

  /// Updates a room in the Firestore. Accepts any room.
  /// Room will probably be taken from the [rooms] stream.
  void updateRoom(types.Room room) async {
    final roomMap = room.toJson();
    roomMap.removeWhere((key, value) =>
        key == 'createdAt' ||
        key == 'id' ||
        key == 'lastMessages' ||
        key == 'users');

    if (room.type == types.RoomType.direct) {
      roomMap['imageUrl'] = null;
      roomMap['name'] = null;
    }

    roomMap['lastMessages'] = room.lastMessages?.map((m) {
      final messageMap = m.toJson();

      messageMap.removeWhere((key, value) =>
          key == 'author' ||
          key == 'createdAt' ||
          key == 'id' ||
          key == 'updatedAt');

      messageMap['authorId'] = m.author.id;

      return messageMap;
    }).toList();
    roomMap['updatedAt'] = FieldValue.serverTimestamp();
    roomMap['userIds'] = room.users.map((u) => u.id).toList();

    await getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .doc(room.id)
        .update(roomMap);
  }

  /// Returns a stream of all users from Firebase.
  Stream<List<types.User>> users() {
    if(AppProvider.myId.isEmpty)throw Exception('myId null');
    return getFirebaseFirestore()
        .collection(config.usersCollectionName)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<List<types.User>>(
            [],
            (previousValue, doc) {
              if (AppProvider.myId == doc.id) return previousValue;

              final data = doc.data();

              data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
              data['id'] = doc.id;
              data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
              data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

              return [...previousValue, types.User.fromJson(data)];
            },
          ),
        );
  }
}

extension RoomH on types.Room {
  types.User get me =>
      users.firstWhere((e) => e.id == AppProvider.myId);

  types.User get otherUser =>
      users.firstWhere((e) => e.id != AppProvider.myId);

  int get latestSeen => metadata?['latestSeen'] ?? 0;

  bool get isRead {
    if ((lastMessages ?? []).isEmpty) return true;
    final latestMessage = lastMessages!.first;
    return ((latestMessage.author.id == AppProvider.myId) ||
        ((latestSeen - (updatedAt ?? 0)) > 0));
  }

  bool get isNotRead => !isRead;
}

extension UserH on types.User {
  String get name => '$firstName';
}

extension MessageH on types.Message {
  Widget latestMessage(types.Room room) {
    bool isRead = room.isRead;
    String message = '';
    dynamic icon;

    if (this is types.CustomMessage) {
      return 0.0.verticalSpace;
    } else if (this is types.FileMessage) {
      message = 'ملف';
      icon = Icons.file_copy;
    } else if (this is types.ImageMessage) {
      message = 'صورة';
      icon = Icons.image;
    } else if (this is types.TextMessage) {
      message = (this as types.TextMessage).text;
      icon = Icons.message;
    }

    return DrawableText(
      text: message,
      matchParent: true,
      maxLines: 1,
      size: 14.0.sp,
      color: isRead ? Colors.grey : AppColorManager.mainColor,
      fontFamily: isRead ? null : FontManager.cairoBold.name,
      drawablePadding: 7.0.w,
      drawableStart: ImageMultiType(
        color: isRead ? Colors.grey : AppColorManager.mainColor,
        url: icon,
        height: 17.0.r,
        width: 17.0.r,
      ),
    );
  }
}
