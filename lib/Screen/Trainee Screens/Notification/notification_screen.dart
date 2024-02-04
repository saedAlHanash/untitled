import 'package:fitness_storm/Screen/Trainee%20Screens/Notification/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widget/empty_screen.dart';
import 'Widget/notification_widget.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text('notifications'.tr),
          titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : RefreshIndicator(
                onRefresh: () async {
                  controller.getAllNotification1();
                },
                child: controller.notifications.data.isEmpty
                    ? const EmptyScreen()
                    : SizedBox(
                        height: Get.height + 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 200.0),
                          itemCount: controller.notifications.data.length,
                          itemBuilder: (context, index) {
                            List data = controller.notifications.data.toList();
                            return NotificationWidget(item: data[index]);
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
