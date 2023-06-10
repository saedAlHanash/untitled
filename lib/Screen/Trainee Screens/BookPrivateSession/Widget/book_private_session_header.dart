import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/BookPrivateSession/book_private_session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/Constants/constants.dart';

class BookPrivateSessionHeader extends GetWidget<BookPrivateSessionController> {
  const BookPrivateSessionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
      child: Column(
        children: [
          SizedBox(height: Get.height / 30),
          Container(
            width: Get.width / 4,
            height: Get.width / 4,
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
                imageUrl: Constants.imageUrl +
                    controller.trainerProfileImage.toString(),
                fadeInDuration: const Duration(seconds: 1),
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset('asset/Images/user.png', fit: BoxFit.fitWidth),
              ),
            ),
          ),
          SizedBox(height: Get.height / 50),
          Text(
            controller.trainerName,
            style: const TextStyle(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Get.height / 25),
          Text(
            'what_will_you_get_in_this_private_session?'.tr,
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "${controller.trainerName} " + 'will_provide_personalized'.tr,
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
