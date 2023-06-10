import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TrainerProfileCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function onTap;

  const TrainerProfileCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: Get.width / 2.5,
        height: Get.height / 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFF5F5F5)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(imageUrl),
              Text(title,
                  style: const TextStyle(
                      color: Color(0xFF565C63),
                      fontSize: 14,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
