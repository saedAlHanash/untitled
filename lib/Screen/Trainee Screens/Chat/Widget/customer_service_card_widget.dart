import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';

class CustomerServiceCardwidget extends StatelessWidget {


  const CustomerServiceCardwidget({
    super.key,
  });

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
          margin: EdgeInsets.only(left: Get.width / 12.5, right: Get.width / 18.75),
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
          alignment: Alignment.center,
          child: const ImageMultiType(url: Assets.imagesCallCenter),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'customer_service'.tr,
              style: const TextStyle(
                  color: Color(0xFF565C63), fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ]),
    );
  }
}
