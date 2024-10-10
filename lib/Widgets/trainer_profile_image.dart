import 'package:flutter/material.dart';
import 'package:image_multi_type/circle_image_widget.dart';

class TrainerProfileImage extends StatelessWidget {
  final String trainerImageUrl;

  const TrainerProfileImage({super.key, required this.trainerImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: CircleImageWidget(url: trainerImageUrl),
    );
  }
}
