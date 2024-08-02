import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../core/api_manager/api_service.dart';
import '../../core/app/app_provider.dart';
import '../../core/util/shared_preferences.dart';
import 'core/firebase_chat_core.dart';
import 'core/util.dart';

class ChatServiceCore {
  static Future<void> initFirebaseChat() async {
    if (AppProvider.isGuest || AppProvider.token.isEmpty ||
        AppProvider.myId.isEmpty) return;
    loginChatUser();
    return;
  }

  static Future<bool> loginChatUser() async {
    if (AppProvider.myId.isEmpty) return false;
    if (AppSharedPreference.getIsLoginToChatApp) return true;
    final profile = AppProvider.profile;
    try {
      if (profile.id == 0) return false;
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          id: profile.id.toString(),
          firstName: profile.name,
          imageUrl: profile.image,
          lastName: '',
          role: types.Role.user,
          metadata: await profile.toJsonChatApp(),
        ),
      );
      await AppSharedPreference.cashLoginToChatApp(true);
      return true;
    } catch (e) {
      loggerObject.e(e);
      return false;
    }
  }

  static Future<bool> createUser(TrainerModel trainer) async {
    try {
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          id: trainer.id.toString(),
          firstName: trainer.name,
          imageUrl: trainer.image,
          lastName: '',
          role: types.Role.user,
        ),
      );
      await AppSharedPreference.cashLoginToChatApp(true);
      return true;
    } catch (e) {
      loggerObject.e(e);
      return false;
    }
  }

  static Future<List<types.User>> _getChatUsers() async {
    final users = await FirebaseFirestore.instance.collection('users').get();

    final listUsers = users.docs.map((doc) {
      final data = doc.data();

      data['id'] = doc.id;
      data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
      data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
      data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

      return types.User.fromJson(data);
    }).toList();

    return listUsers;
  }

  static Future<types.User?> getUser(String userId,
      {TrainerModel? trainer}) async {
    final user =
    (await _getChatUsers()).firstWhereOrNull((e) => e.id == userId);

    if (user == null) {
      if (trainer != null) {
        await createUser(trainer);
        return getUser(userId);
      }
    }
    return user;
  }

  static Future<bool> logoutChatUser() async {
    if (!AppSharedPreference.getIsLoginToChatApp) return true;
    if (AppProvider.myId.isEmpty) return true;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(AppProvider.myId)
          .update({'metadata': {}});
      await AppSharedPreference.cashLoginToChatApp(false);
      return true;
    } catch (e) {
      loggerObject.e(e);
      return false;
    }
  }

  static Future<bool> updateChatUser() async {
    if (AppProvider.myId.isEmpty) return false;
    try {
      final profile = AppProvider.profile;
      if (profile.id == 0) return false;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(AppProvider.myId)
          .update(types.User(
        id: profile.id.toString(),
        firstName: profile.name,
        imageUrl: profile.image,
        lastName: '',
        role: types.Role.user,
        metadata: await profile.toJsonChatApp(),
      ).toJson());
      return true;
    } catch (e) {
      loggerObject.e(e);
      return false;
    }
  }

  static Future<bool> latestSeenRoom(String roomId) async {
    try {
      await FirebaseChatCore.instance.latestSeenRoom(roomId);
      return true;
    } catch (e) {
      loggerObject.e(e);
      return false;
    }
  }

  static Future<List<types.User>> getChatUsers() async {
    final users = await FirebaseFirestore.instance.collection('users').get();

    final listUsers = users.docs.map((doc) {
      final data = doc.data();

      data['id'] = doc.id;
      data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
      data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
      data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

      return types.User.fromJson(data);
    }).toList();

    return listUsers;
  }

  static Future<List<types.Room>> getChatRooms() async {
    final roomQuery = await FirebaseChatCore.instance.getFirebaseFirestore()
        .collection('rooms')
        .get();

    final rooms = (await processRoomsQuery(
      FirebaseChatCore.instance.getFirebaseFirestore(),
      roomQuery,
      'users',
    ));
    return rooms;
  }

}
