import 'package:flutter/material.dart';

import '../../../../Trainer Screens/Trainer Overview/Widget/ProfileHader/chat_and_video_button_widget.dart';

class TrainerProfileInfowidget extends StatelessWidget {
  final String trainerName;

  const TrainerProfileInfowidget({super.key, required this.trainerName});

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
                  trainerName,
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
              ChatAndVideoButtonWidget(trainerName: trainerName),
            ],
          ),
          // SizedBox(height: Get.height / 6)
        ],
      ),
    );
  }
}
