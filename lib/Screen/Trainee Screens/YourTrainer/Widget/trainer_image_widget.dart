import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerImageWidget extends StatelessWidget {
  final String imageUrl;

  const TrainerImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
      height: double.infinity,
      width: Get.width / 4,
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
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
