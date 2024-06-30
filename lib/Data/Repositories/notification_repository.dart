import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Api/urls.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:get/get.dart';

import '../../features/notifications/data/response/notifications_response.dart';

class NotificationRepository {
  static final _dio = Get.find<Dio>();

  Future<NotificationsResponse> getAllNotifications(bool isTrainer) async {
    Options option = Utils.getOptions(withToken: true, all: true);
    NotificationsResponse notifications = NotificationsResponse.fromJson({});
    var response = await _dio.get(
      isTrainer ? TRAINERURLS.allNotifications : TRAINEEURLS.allNotifications,
      options: option,
    );
    if (response.statusCode == 200) {
      notifications = NotificationsResponse.fromJson(response.data);
    }
    return notifications;
  }

  Future<void> resetAllNotification(bool isTrainer) async {
    Options option = Utils.getOptions(withToken: true, all: true);

    await Methods.put(
        url:
            isTrainer ? TRAINERURLS.restAllNotification : TRAINEEURLS.restAllNotification,
        options: option);
  }
}
