
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';

class TrainerProfileImageWidget extends StatelessWidget {
  final String imageUrl;

  const TrainerProfileImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 8,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: CircleImageWidget(url: imageUrl),
    );
  }
}

