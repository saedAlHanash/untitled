import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class SuccessSubscribed extends StatelessWidget {
  const SuccessSubscribed({super.key, required this.nameUser});

  final String nameUser;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: Get.width / 11.1,
        height: Get.height / 11.7,
        child: ImageMultiType(url: "assets/images/successfully.svg"),
      ),
      SizedBox(height: Get.height / 16.24),
      Text(
        '${'welcome'.tr} $nameUser',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      SizedBox(height: Get.height / 40.6),
      Text(
        'congratulations'.tr,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      SizedBox(height: Get.height / 13.8),
      // CustomButton(
      //     onTapFunction: () => Get.back(),
      //     fontSize: 16,
      //     textColor: Colors.white,
      //     padding: 0,
      //     margin: 0,
      //     text: 'Choose a Plan')
    ]);
  }
}
