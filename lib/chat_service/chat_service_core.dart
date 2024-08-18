import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../api_manager/api_service.dart';
import '../go_route_pages.dart';
import 'core/firebase_chat_core.dart';

class ChatServiceCore {
  static Future<void> initFirebaseChat() async {
    loginChatUser();
    return;
  }

  static Future<bool> loginChatUser() async {
    try {

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          id: '0',
          firstName: 'Fitness Support',
          imageUrl: 'https://www.seqrite.com/skin/frontend/default/seqrite_v1/images/support-img.png',
          lastName: '',
          role: types.Role.admin,
          metadata: metaQuery.toJson(),
        ),
      );

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

  static Future<types.User?> getUser(String userId) async {
    final user = (await getChatUsers()).firstWhereOrNull((e) => e.id == userId);
    return user;
  }

  static Future<bool> logoutChatUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('0')
          .update({'metadata': {}});
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
