import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Widgets/custom_button.dart';

class PrivateCoatching extends StatelessWidget {
  final String price;

  const PrivateCoatching({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 4,
      width: Get.width,
      child: Card(
        elevation: 20,
        child: Column(
          children: [
            SizedBox(height: Get.height / 40.6),
            Container(
              color: Get.theme.colorScheme.secondary,
              padding: EdgeInsets.symmetric(horizontal: Get.width / 37.5),
              child: Text(
                'take_a_plan_made_customized_for_you!'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(height: ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height / 100.75),
              child: Text(
                'private_coatching'.tr,
                style: const TextStyle(
                  color: Color(0xFF565C63),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$price SAR",
                  style: const TextStyle(
                      color: Color(0xFF565C63),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Get.height / 100),
                  child: Text(
                    '/${'month'.tr}',
                    style: const TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
            CustomButton(
              onTapFunction: () {},
              padding: 0,
              margin: 0,
              fontSize: 14,
              textColor: Colors.white,
              text: 'subscribe'.tr,
            )
          ],
        ),
      ),
    );
  }
}
