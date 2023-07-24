import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/chat_controller.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatCardWidget extends GetWidget<ChatController> {
  final String imagePath;
  final String trainerName;
  final String? lastMessage;

  const ChatCardWidget(
      {super.key,
      required this.imagePath,
      required this.trainerName,
      required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 9,
      width: Get.width,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: Get.height / 162.4),
      child: Row(children: [
        Container(
            width: Get.width / 6,
            height: Get.width / 6,
            margin: EdgeInsets.only(
                left: Get.width / 12.5, right: Get.width / 18.75),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 8,
                  offset: const Offset(0, 10), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: Constants.imageUrl + imagePath,
                fadeInDuration: const Duration(seconds: 1),
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
                errorWidget: (context, url, error) =>
                    Image.asset('asset/Images/user.png', fit: BoxFit.fill),
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trainerName,
              style: const TextStyle(
                  color: Color(0xFF565C63),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              lastMessage ?? '',
              style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 16),
            )
          ],
        )
      ]),
    );
  }
}
