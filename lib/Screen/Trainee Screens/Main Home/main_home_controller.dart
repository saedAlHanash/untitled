import 'package:fitness_storm/Screen/Trainee%20Screens/Main%20Home/Widget/navigation_bar_controller.dart';
import 'package:get/get.dart';

import '../../../Data/Repositories/notification_repository.dart';
import '../../../Model/notification_model.dart';

class MainHomeController extends GetxController {
  AppNavigationBarController navController = AppNavigationBarController();
  late NotificationModel notifications = NotificationModel();
  String? token;

  final RxBool _isLoading = false.obs;
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  final RxInt _numberOfNotification = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;
    await getAllNotifications();
    numberOfNotification = notifications.unReadNotification;
    isLoading = false;
  }

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  int get numberOfNotification => _numberOfNotification.value;

  set numberOfNotification(value) => _numberOfNotification.value = value;

  Future<void> getAllNotifications() async {
    notifications = await _notificationRepository.getAllNotifications(false);
    numberOfNotification = notifications.unReadNotification;
   //   print('dfsdfsadf');
   //   print(numberOfNotification);
  }
}
