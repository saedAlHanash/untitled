import 'dart:async';


import 'package:chat_web_app/api_manager/api_service.dart';


import 'my_room_object.dart';

Future<bool> sendNotificationMessage(
    MyRoomObject myRoomObject, ChatNotification message) async {
  if (myRoomObject.fcmToken.isEmpty && myRoomObject.fcmTokenWeb.isEmpty) return false;

  if (message.body.length > 100) {
    message.body = message.body.substring(0, 99);
  }

  final result = await APIService().uploadMultiPart(
    url: 'api/send',
    fields: message.toJson(),
  );

  return result.statusCode == 200;
}

