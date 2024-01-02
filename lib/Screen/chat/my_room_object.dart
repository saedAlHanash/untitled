class MyRoomObject {
  String roomId;
  bool needToSendNotification;
  String fcmToken;

  MyRoomObject({
    this.roomId = '',
    this.fcmToken = '',
    this.needToSendNotification = true,
  });
}

class ChatNotification {


  String body;

  ChatNotification({
    required this.body,
  });
}
