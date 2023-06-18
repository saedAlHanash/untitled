class MyRoomObject {
  String roomId;
  bool isMemberInRoom;
  bool needToSendNotification;
  String fcmToken;

  MyRoomObject({
    this.roomId = '',
    this.fcmToken = '',
    this.isMemberInRoom = false,
    this.needToSendNotification = true,
  });
}

class ChatNotification {

  String title;
  String body;

  ChatNotification({
    required this.title,
    required this.body,
  });
}
