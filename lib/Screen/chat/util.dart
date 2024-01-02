import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Screen/chat/my_room_object.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:saed_http/api_manager/api_service.dart';

import '../../Model/trainer.dart';
import '../../main.dart';

extension TypesRoom on types.Room {
  bool get isNotReed {
    if (createdAt == updatedAt) return false;
    final result = (updatedAt ?? 0) - (latestUpdateMessagesBox.get(id) ?? 0);
    // loggerObject.w('$id $updatedAt - ${(latestUpdateMessagesBox.get(id))} = $result');
    return result > 2000;
  }
}

final firebaseUser = FirebaseChatCore.instance.firebaseUser;

Future<List<types.User>> getChatUsers() async {
  final users = await FirebaseFirestore.instance.collection('users').get();

  final listUsers = users.docs.map((doc) {
    final data = doc.data();

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

    return types.User.fromJson(data);
  }).toList();

  return listUsers;
}

types.User getChatMember(List<types.User> list, {bool? me}) {
  for (var e in list) {
    if (me ?? false) {
      if (e.id == FirebaseAuth.instance.currentUser?.uid) {
        return e;
      }
    } else if (e.id != FirebaseAuth.instance.currentUser?.uid) {
      return e;
    }
  }
  throw Exception('user not found');
}

Future<bool> isChatUserFound(String id) async {
  for (var e in await getChatUsers()) {
    if (e.firstName == id) return true;
  }
  return false;
}

Future<void> createChatUser(Trainer profile) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'fitnes.${profile.id}@fitnes.com',
      password: '98898${profile.id}!@qweDSAFCA',
    );

    await FirebaseChatCore.instance.createUserInFirestore(
      types.User(
        firstName: profile.id,
        id: credential.user!.uid,
        lastName: profile.name,
        metadata: {'fcm': await FirebaseMessaging.instance.getToken()},
      ),
    );
  } on Exception catch (e) {
    if (e.toString().contains('email address is already')) {
      loginChatUser(profile.id!, profile.name!);
    }
  }
}

Future<void> loginChatUser(String id, String name) async {
  var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'fitnes.$id@fitnes.com',
    password: '98898$id!@qweDSAFCA',
  );

  await FirebaseChatCore.instance.createUserInFirestore(
    types.User(
        firstName: id,
        id: credential.user!.uid,
        lastName: name,
        metadata: {'fcm': await FirebaseMessaging.instance.getToken()}),
  );
}

Future<void> logoutChatUser() async {
  if (FirebaseAuth.instance.currentUser != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(
      {
        'metadata': {'fcm': ''},
      },
    );
  }

  await roomsBox.clear();
  await FirebaseAuth.instance.signOut();
}

Future<bool> sendNotificationMessage(
    MyRoomObject myRoomObject, ChatNotification message) async {
  loggerObject.w('message');
  if (myRoomObject.fcmToken.isEmpty) return false;

  if (message.body.length > 100) {
    message.body = message.body.substring(0, 99);
  }
  final result = await APIService().postApi(
    url: 'mobile/api/send-notification',
    body: {"token": myRoomObject.fcmToken, "message": message.body},
  );
  return result.statusCode == 200;
}
