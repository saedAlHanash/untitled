import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationWidget extends StatelessWidget {
  final String title;
  final String date;

  const NotificationWidget({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 12, vertical: 20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Color(0xFF565C63),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            date,
            style: const TextStyle(
              color: Color(0xFFA0A0A0),
              fontSize: 16,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
