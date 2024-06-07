import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/api_manager/api_service.dart';
import '../../main.dart';
import 'get_chats_rooms_bloc/get_rooms_cubit.dart';
import 'my_room_object.dart';

extension TypesRoom on types.Room {
  bool get isNotReed {
    if (createdAt == updatedAt) return false;
    final result = (updatedAt ?? 0) - (latestUpdateMessagesBox.get(id) ?? 0);
    // //loggerObject.w('$id $updatedAt - ${(latestUpdateMessagesBox.get(id))} = $result');
    return result > 2000;
  }
}

User? get firebaseUser {
  final user = FirebaseChatCore.instance.firebaseUser;
  if (user == null) _initial();
  return user;
}

Future<User?> get firebaseUserAsync async {
  final user = FirebaseChatCore.instance.firebaseUser;

  if (user == null) {
    await _initial();
    return firebaseUser;
  }

  return user;
}

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
      if (e.id == firebaseUser?.uid) {
        return e;
      }
    } else if (e.id != firebaseUser?.uid) {
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

Future<void> createChatUser(String id, String? name, String? photo) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'fitnes.$id@fitnes.com',
      password: '98898$id!@qweDSAFCA',
    );

    await FirebaseChatCore.instance.createUserInFirestore(
      types.User(
        firstName: id,
        id: credential.user!.uid,
        imageUrl: photo,
        lastName: name ?? DateTime.now().toString(),
        metadata: {'fcm': await FirebaseMessaging.instance.getToken()},
      ),
    );
  } on Exception catch (e) {
    if (e.toString().contains('email address is already')) {
      loginChatUser(id, name, photo);
    }
  }
}

Future<void> loginChatUser(String id, String? name, String? photo) async {
  var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'fitnes.$id@fitnes.com',
    password: '98898$id!@qweDSAFCA',
  );

  await FirebaseChatCore.instance.createUserInFirestore(
    types.User(
        firstName: id,
        id: credential.user!.uid,
        imageUrl: photo,
        lastName: name ?? DateTime.now().toString(),
        metadata: {'fcm': await FirebaseMessaging.instance.getToken()}),
  );
}

Future<void> logoutChatUser() async {
  if (firebaseUser != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser?.uid)
        .update(
      {
        'metadata': {'fcm_web': ''}
      },
    );
  }
  //loggerObject.w('logout');

  await roomsBox.clear();

  await reInitialHive();

  await FirebaseAuth.instance.signOut();

  Get.context?.read<RoomsCubit>().reInitial();
}

Future<void> initFirebaseChat() async {
  if (AppProvider.isGuest) return;
  final id = AppProvider.profile.id;
  final name = AppProvider.profile.name;
  final photo = AppProvider.profile.image;
  if (id == 0) return;

  try {
    if (await isChatUserFound(id.toString())) {
      loginChatUser(id.toString(), name, photo);
      return;
    } else {
      createChatUser(id.toString(), name, photo);
    }
  } on Exception catch (e) {
    print(e);
  }
  return;
}

Future<void> initFirebaseChatAfterLogin() async {
  if (AppProvider.isGuest) return;
  final id = AppProvider.profile.id;
  final name = AppProvider.profile.name;
  final photo = AppProvider.profile.image;
  if (id == 0) return;

  try {
    if (await isChatUserFound(id.toString())) {
      await loginChatUser(id.toString(), name, photo);
    } else {
      await createChatUser(id.toString(), name, photo);
    }
  } on Exception {
    if (firebaseUser != null) {
      Get.context?.read<RoomsCubit>().getChatRooms();
    }
  }

  if (firebaseUser != null) {
    Get.context?.read<RoomsCubit>().getChatRooms();
  }
}

Future<bool> sendNotificationMessage(
    MyRoomObject myRoomObject, ChatNotification message) async {
  if (myRoomObject.fcmToken.isEmpty) return false;

  if (message.body.length > 100) {
    message.body = message.body.substring(0, 99);
  }

  final result = await APIService().postApi(
    url: 'api/send-notification',
    additional: '',
    body: {"token": myRoomObject.fcmToken, "message": message.body},
  );
  return result.statusCode == 200;
}

var loading = false;

Future<void> _initial() async {
  if (loading) return;
  loading = true;

  if (FirebaseChatCore.instance.firebaseUser != null) return;

  await initFirebaseChat();
  loading = false;
}

class UtilBoxes {
  Box<String>? roomsBox;

  Box<String>? messageBox;

  Box<String>? latestMessagesBox;

  UtilBoxes();

  Future<bool> initialBoxes() async {
    roomsBox = Hive.isBoxOpen('rooms')
        ? Hive.box<String>('rooms')
        : await Hive.openBox<String>('rooms');

    latestMessagesBox = Hive.isBoxOpen('latestMessagesBox')
        ? Hive.box<String>('latestMessagesBox')
        : await Hive.openBox<String>('latestMessagesBox');

    return true;
  }

  Future<void> reInitialBoxes() async {
    await roomsBox?.close();

    await latestMessagesBox?.close();

    roomsBox = await Hive.openBox('roomsBox');

    latestMessagesBox = await Hive.openBox('latestMessagesBox');
  }
}
