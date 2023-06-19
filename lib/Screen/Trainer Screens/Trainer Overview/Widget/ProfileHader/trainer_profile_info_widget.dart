import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Model/trainer.dart';
import 'chat_and_video_button_widget.dart';

class TrainerProfileInfowidget extends StatelessWidget {
  final Trainer trainer;

  const TrainerProfileInfowidget({
    super.key,
    required this.trainer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.8,
      padding: EdgeInsets.only(top: Get.height / 41.5, left: Get.width / 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            trainer.name ?? '',
            style: const TextStyle(
              color: Color(0xFF565C63),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          ChatAndVideoButtonWidget(
            trainer: trainer,
          )
        ],
      ),
    );
  }
}
