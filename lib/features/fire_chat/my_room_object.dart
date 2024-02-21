class MyRoomObject {
  String roomId;
  bool needToSendNotification;
  String fcmToken;
  String fcmTokenWeb;

  MyRoomObject({
    this.roomId = "",
    this.fcmToken = "",
    this.fcmTokenWeb = "",
    this.needToSendNotification = true,
  });
}

class ChatNotification {
  String body;
  String title;
  String fcm;
  String fcmWeb;

  ChatNotification({
    required this.body,
    required this.title,
    required this.fcm,
    required this.fcmWeb,
  });

  Map<String, dynamic> toJson() {
    return {
      "body": body,
      "title": title,
      if (fcm.isNotEmpty) "fcm_token[0]": fcm,
      if (fcmWeb.isNotEmpty) "fcm_token[${fcm.isEmpty ? '0' : '1'}]": fcmWeb,
    };
  }
}
