import 'package:fitness_storm/Data/Repositories/notification_repository.dart';
import 'package:fitness_storm/Model/notification_model.dart';
import 'package:fitness_storm/helperClass.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxBool _isLoading = false.obs;
  late NotificationModel notifications = NotificationModel();
  final NotificationRepository _notificationRepository =
      NotificationRepository();
  late final bool isTrainer;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  @override
  Future<void> onInit() async {
    isTrainer = Get.arguments[0];
    HelperClass.isTrainerGloabl = isTrainer;
    super.onInit();
    isLoading = true;

    await resetAllNotification(isTrainer);
    await getAllNotification(isTrainer);

   //   print(isLoading);
    isLoading = false;
   //   print(isLoading);
  }

  Future<void> resetAllNotification(bool isTrainer) =>
      _notificationRepository.resetAllNotification(isTrainer);

  Future<void> getAllNotification(bool isTrainer) async {
    notifications =
        await _notificationRepository.getAllNotifications(isTrainer);
  }
  Future<void> getAllNotification1() async {
        isLoading = true;
    notifications =
        await _notificationRepository.getAllNotifications(isTrainer);
        isLoading = false;
  }
}
