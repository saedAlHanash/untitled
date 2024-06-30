
import '../../core/api_manager/api_service.dart';
import '../../core/strings/enum_manager.dart';
import 'my_room_object.dart';

Future<bool> sendNotificationMessage(
    MyRoomObject myRoomObject, ChatNotification message) async {
  if (myRoomObject.fcmToken.isEmpty) return false;

  if (message.body.length > 100) {
    message.body = message.body.substring(0, 99);
  }

  final result = await APIService().callApi(
    type: ApiType.post,
    url: 'api/send-notification',
    additional: '',
    body: {"token": myRoomObject.fcmToken, "message": message.body},
  );
  return result.statusCode == 200;
}



