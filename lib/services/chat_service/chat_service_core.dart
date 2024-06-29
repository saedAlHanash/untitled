import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../core/api_manager/api_service.dart';
import '../../core/app/app_provider.dart';
import '../../core/util/shared_preferences.dart';
import 'core/firebase_chat_core.dart';

class ChatServiceCore {

  static Future<void> initFirebaseChat() async {
    if (AppProvider.isGuest || AppProvider.token.isEmpty) return;
    loginChatUser();
    return;
  }

  static Future<bool> loginChatUser() async {
    if (AppSharedPreference.getIsLoginToChatApp) return true;
    final profile = AppProvider.profile;
    try {
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

  static Future<types.User?> getUser(String userId) async {
    return (await _getChatUsers()).firstWhereOrNull((e) => e.id == userId);
  }

  static Future<bool> isRegistered() async {
    final users = await FirebaseFirestore.instance.collection('users').get();
    return users.docs.firstWhereOrNull(
          (e) {
            return e['metadata']?['id'] == '${AppProvider.myId}';
          },
        ) !=
        null;
  }

  static Future<bool> logoutChatUser() async {
    if (!AppSharedPreference.getIsLoginToChatApp) return true;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(AppProvider.myId.toString())
          .update({'metadata': {}});
      await AppSharedPreference.cashLoginToChatApp(false);
      return true;
    } catch (e) {
      loggerObject.e(e);
      return false;
    }
  }

  static Future<bool> updateChatUser() async {
    try {
      final profile = AppProvider.profile;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(AppProvider.myId.toString())
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
}
