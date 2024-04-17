import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoButton extends StatelessWidget {
  final String title;
  final onTap;

  InfoButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFF5F5F5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 2.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: Get.height / 60),
        child: Center(
            child: Text(title,
                // maxLines: 2,
                style:
                    const TextStyle(color: Color(0xFF565C63), fontSize: 15))),
      ),
    );
  }
}
