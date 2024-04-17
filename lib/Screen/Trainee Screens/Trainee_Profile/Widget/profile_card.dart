import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final Color? iconColor;
  final String title;
  final Function onTap;

  const ProfileCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: Get.width / 2.5,
        height: Get.height / 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFF5F5F5)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                imageUrl,
                color: iconColor,
                height: 30,
              ),
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
