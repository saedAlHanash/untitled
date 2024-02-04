import 'package:fitness_storm/Model/notification_model.dart';
import 'package:fitness_storm/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.item,
  });

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 12, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.body}\n${item.data == null ? '' : '${item.data!.date?.formatDateTime ?? ''}\n'}',
                style: const TextStyle(
                    color: Color(0xFF565C63), fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                item.createdAt,
                style: const TextStyle(
                  color: Color(0xFFA0A0A0),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
