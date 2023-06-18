import 'package:flutter/material.dart';

import '../../../../../Model/trainer.dart';
import '../../../../Trainer Screens/Trainer Overview/Widget/ProfileHader/chat_and_video_button_widget.dart';

class TrainerProfileInfowidget extends StatelessWidget {
  final Trainer trainer;

  const TrainerProfileInfowidget({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 7),
              FittedBox(
                child: Text(
                  trainer.name??'',
                  style: const TextStyle(
                    color: Color(0xFF565C63),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 7),
              ChatAndVideoButtonWidget(trainer: trainer),
            ],
          ),
          // SizedBox(height: Get.height / 6)
        ],
      ),
    );
  }
}
