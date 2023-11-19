import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Screen/chat/my_room_object.dart';
import 'package:fitness_storm/Utils/storage_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../Data/Api/methods.dart';
import '../../Model/trainer.dart';

Future<List<types.User>> getChatUsers() async {
  // if (StorageController().listUsers.isNotEmpty) return StorageController().listUsers;

  final users = await FirebaseFirestore.instance.collection('users').get();

  final listUsers = users.docs.map((doc) {
    final data = doc.data();

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

    return types.User.fromJson(data);
  }).toList();

  StorageController().listUsers = listUsers;

  return listUsers;
}

Future<List<types.Room>> getChatRooms() async {
  print(FirebaseAuth.instance.currentUser);
  if (FirebaseAuth.instance.currentUser == null) return [];
  if (StorageController().listRooms.isNotEmpty) return StorageController().listRooms;

  final rooms = await FirebaseFirestore.instance
      .collection('rooms')
      .where(
        'userIds',
        arrayContains: FirebaseAuth.instance.currentUser?.uid,
      )
      .get();

  final listRooms = await processRoomsQuery(
    FirebaseAuth.instance.currentUser!,
    FirebaseFirestore.instance,
    rooms,
    'users',
  );

  StorageController().listRooms = listRooms;

  return listRooms;
}

Future<String> test() async {
  return '';
}

Future<types.Room?> getRoomByUser(String? id) async {
  if (id == null) return null;

  final rooms = await getChatRooms();
  for (var e in rooms) {
    for (var e1 in e.users) {
      if (e1.firstName == id) {
        return e;
      }
    }
  }

  for (var e in await getChatUsers()) {
    if (e.firstName == id) {
      var newRoom = await FirebaseChatCore.instance.createRoom(e);
      StorageController().listRooms.add(newRoom);
      return newRoom;
    }
  }
  return null;
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
  await getChatUsers();
  for (var e in StorageController().listUsers) {
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
      loginChatUser(profile.id!,profile.name!);
    }
  }
}

Future<void> loginChatUser(String id ,String name) async {
  var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'fitnes.$id@fitnes.com',
    password: '98898$id!@qweDSAFCA',
  );

  await FirebaseChatCore.instance.createUserInFirestore(
    types.User(
        firstName: id,
        id: credential.user!.uid,
        lastName:name,
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

  await FirebaseAuth.instance.signOut();
}

var dio = Dio();

Future<void> sendNotificationMessage(
    MyRoomObject myRoomObject, ChatNotification message) async {
  if (!myRoomObject.needToSendNotification || myRoomObject.fcmToken.isEmpty) return;

  if (message.body.length > 100) {
    message.body = message.body.substring(0, 99);
  }

  var data = {
    'notification': {'title': message.title, 'body': message.body},
    'to': myRoomObject.fcmToken,
  };
  var response = await dio.post(
    'https://fcm.googleapis.com/fcm/send',
    data: data,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAlhv4BrU:APA91bGDGCjqhQRkl69cqUwENh7jpw3nE8wxUuZiifz4T5Pz_rbNdHzKdqZD13V6y49Oh70enJ2BvCULLBshlu6V1PhvPb_THE36hv7p7qyl3NbKVXEzhapbrUKSUg_c3W3_vmG0i-hd',
      },
    ),
  );
  StorageController().myRoomObject.needToSendNotification = false;
}

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}

String getUserName(types.User user) =>
    '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
